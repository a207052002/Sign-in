module NCU
  module OAuth
    module Helpers
      def token_string
        return @token_string unless @token_string.nil?
        @tokne_string ||= headers['AUTHORIZATION'][/^Bearer (.*)/,1]
      end

      def token_info
        return @token_info unless @token_info.nil?
        RestClint.get Setting::OAUTH_ACCESS_TOKEN_URL, {authorization: "Bearer #{token_string}"} do |response, request, result, &block|
          @token_info = response
        end
        @token_info
      end

      def access_token
        return @access_token unless @access_token.nil?
        return @access_token = 400 if token_string.nil?
        if token_info.code == 200
          res = JSON.parse(token_info.body,symbolize_names: true)
          return @access_token = res unless res[:resource_owner_id].nil?
          @access_token = 401
        end
        @access_token
      end
    end
  end
end
