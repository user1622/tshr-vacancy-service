module JobPlatformClient
  module JobPlatform
    class DevBy < Base
      SIGN_IN_URL = 'https://id.dev.by/@/hello'.freeze
      MAIN_URL = 'https://dev.by/'.freeze

      def sign_in?(session_data)
        http_client.url = MAIN_URL
        http_client.headers = headers(session_data)
        http_client.perform
        http_client.body_str !~ /#{SIGN_IN_URL}/
      end

      def sign_in(username:, password:)
        http_client.url = SIGN_IN_URL
        http_client.headers = headers
        http_client.perform

        token = extract_token(http_client.body_str)
        raise 'Can not extract token' unless token

        http_client.url = SIGN_IN_URL
        http_client.headers = sign_in_headers(token)
        http_client.post_body = sign_in_post_body(username, password)
        http_client.perform

        http_cookie = HTTP::CookieJar.new
        cookies = []
        http_client.header_str.split("\n").each do |line|
          next unless line =~ /set-cookie/i
          cookies += http_cookie.parse(line.split(/set-cookie:/i).last, MAIN_URL)
        end

        if http_client.body_str =~ /"error"/
          response = JSON.parse(http_client.body_str, symbolize_names: true)
          { success: false, error: response[:error][:message] }
        else
          {
            success: http_client.body_str !~ /#{SIGN_IN_URL}/,
            session_data: cookies.map(&:to_s).join('; '),
            session_type: :cookie
          }
        end
      end

      def vacancy(data)
        raise 'Unimplemented'
      end

      protected

      def headers(cookie = nil)
        {
          "User-Agent": USER_AGENT,
          "Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8",
          "Accept-Language": "en-US,en;q=0.5",
          "Accept-Encoding": "gzip, deflate, br",
          "DNT": "1",
          "Connection": "keep-alive",
          "Cookie": cookie,
          "Upgrade-Insecure-Requests": "1",
          "Pragma": "no-cache",
          "Cache-Control": "no-cache",
        }
      end

      def extract_token(response_body)
        response_body[/csrf-token.*?content="([^"]+)"/, 1]
      end

      def sign_in_headers(token)
        {
          "User-Agent": USER_AGENT,
          "Accept": "*/*",
          "Accept-Language": "en-US,en;q=0.5",
          "Accept-Encoding": "gzip, deflate, br",
          "Referer": "https://id.dev.by/@/hello",
          "X-Requested-With": "XMLHttpRequest",
          "X-CSRF-Token": token,
          "Content-Type": "application/json;charset=utf-8",
          "Origin": "https://id.dev.by",
          "DNT": "1",
          "Connection": "keep-alive",
          "Pragma": "no-cache",
          "Cache-Control": "no-cache",
        }
      end

      def sign_in_post_body(username, password)
        {"user":{"login":username,"password":password}}.to_json
      end
    end
  end
end