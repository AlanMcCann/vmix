require 'vmix/error'
require 'vmix/configuration'
require 'vmix/api'
require 'vmix/client'


module Vmix
  extend Configuration

  #Alias for Vmix::Client.new
  #
  # @return [Vmix::Client]

  def self.client(options={})
    Vmix.new(options)
  end

  # Delegate to Vmix::Client
  def self.method_missing(method, *args, &block)
    return super unless client.respond_to?(method)
    client.send(method, *args, &block)
  end

  def self.respond_to?(method, include_private = false)
    client.respond_to?(method, include_private) || super(method, include_private)
  end


end