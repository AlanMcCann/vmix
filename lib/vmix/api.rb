require 'httparty'
require 'openssl'
require 'json'


module Vmix
  class Api
    include HTTParty
    debug_output $stderr
    attr_accessor *Configuration::VALID_OPTIONS_KEYS


    def initialize(options={})
      options = Vmix.options.merge(options)
      @valid_methods = Vmix::Configuration::VMIX_METHODS
      Configuration::VALID_OPTIONS_KEYS.each do |key|
        send("#{key}=", options[key])
      end
    end

    def download_url(download_token, &block)
      # TODO - raise error if no api_password has been set in configuration
      expires = block.nil? ? (Time.now + 6 * 24 * 60 * 60).to_i : block.call.to_i
      digest = OpenSSL::Digest::Digest.new('sha1')
      enc_string = "#{expires}\n#{self.api_password}\n/vmixcore/download?token=#{download_token}"
      hmac = OpenSSL::HMAC.digest(digest,self.api_password,enc_string)
      signature = URI.escape(Base64.encode64(hmac).strip)
      download_url = "http://#{self.download_endpoint}?token=#{download_token}&expires=#{expires}&signature=#{signature}"
    end

    def available_api_methods
      @valid_methods
    end

    def valid_method?(method)
      method = method.to_s
      if respond_to?(method)
        return true
      else
        return !@valid_methods.select {|k,v| v.include? method}.empty?
      end
    end

    private



    # response = v.getMediaList(:start=>3000,:status_id=>'all',:alltime=>1)

    #  Handle all methods from vmix
    #  TODO: Better error handling

    def method_missing(method, *args,&block)
      puts "method: #{method}"
      if valid_method?(method.to_s)
        get(method.to_sym, *args)
      else
        raise NoMethodError, 'Invalid Vmix API Call'
      end
    end

    def get(method, query = {})

      # Set :output format - default is json, alternatives are xml and jsonp
      if query[:output].nil?
        query.merge(:output => 'json')
      else
        query[:output] = query[:output].to_sym
      end
      output_format = query[:output] || 'json'

      # merge in method and authentication token
      # TODO - do not require token for HTTP Basic Authentication
      query.merge!(:action => method.to_s, :atoken => @token)

      # determine url for method calls
      puts @valid_methods.select {|k,v| v.include? method.to_s}.keys.first.to_s
      url_segment_for_method = "http://" + api_endpoint + "/" + @valid_methods.select {|k,v| v.include? method.to_s}.keys.first.to_s + ".php"
      puts url_segment_for_method

      # execute request and return response
      @response = self.class.get(url_segment_for_method,:query => query)

      # Format return according to output type
      if output_format == 'json' || output_format == 'jsonp'
        return JSON.parse(@response.body)
      else
       return @response.body
      end
    end
    # TODO - Create this
    # def verify_errors(response)
    # end

  end
end