module JobPlatformClient
  module JobPlatform
    class Base
      USER_AGENT = 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:76.0) Gecko/20100101 Firefox/76.0'.freeze

      def sign_in?(user)
        raise 'Unimplemented'
      end

      def sign_in(username:, password:)
        raise 'Unimplemented'
      end

      def vacancy(data)
        raise 'Unimplemented'
      end

      protected

      def http_client
        return @http_client if @http_client

        curl = Curl::Easy.new
        curl.timeout = 10
        curl.connect_timeout = 10
        curl.encoding = ''
        curl.verbose = true
        curl.enable_cookies = true
        @http_client = curl
      end
    end
  end
end