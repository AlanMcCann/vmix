# VmixRubyClient

Ruby wrapper for VMIX REST API

## Installation

Add this line to your application's Gemfile:

    gem 'vmix_ruby_client'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install vmix_ruby_client

## Usage

require "rubygems"
require "vmix_ruby_client"

### All methods require authentication

    Vmix.configure do |config|
      # Endpoint = 'apis.vmixcore.com/apis'
      config.endpoint = REST_API_URL
      # You can choose HTTP Basic Authentication (:http_basic_auth)
      #     or Token Based Authentication (:token_auth)
      config.authentication = YOUR_AUTHENTICATION_METHOD
      # For read requests, only token is required for token-based authentication
      config.token = YOUR_VMIX_API_TOKEN
      # For read and write requests, HTTP Basic Authentication requires username and password
      config.account_id = YOUR_ACCOUNT_ID
      config.api_password = YOUR_API_PASSWORD
    end

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
