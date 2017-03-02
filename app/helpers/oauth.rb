module NCU
  module OAuth
    module Helpers
      def token_string
        @tokne_string ||= headers['Authorization'][/^Bearer (.*)/,1] unless headers['Authorization'].nil?
      end

      def token_info
        return @token_info unless @token_info.nil?
        RestClient.get Settings::OAUTH_ACCESS_TOKEN_URL, {authorization: "Bearer #{token_string}"} do |response, request, result, &block|
          @token_info = response
        end
        @token_info
      end

      def access_token
        return @access_token unless @access_token.nil?
        token_error! 400 if token_string.nil?
        if token_info.code == 200
          res = JSON.parse(token_info.body, symbolize_names: true)
          @access_token = res unless res[:resource_owner_id].nil?
        else
          token_error! 401
        end
      end
    end
  end
end
