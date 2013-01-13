module Vmix
  # Custom error class for rescuing from all Oas errors
  class Error < StandardError
    attr_reader :error_code

    def initialize(message, error_code)
      @error_code = error_code
      super message
    end
  end

  # Raised when the method call is not a valid Vmix API Method
  class InvalidMethod < Error; end

end