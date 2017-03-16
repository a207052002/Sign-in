module HTTP
  module Error
    module Helpers
      def not_found! thing = nil
        if thing
          error! "#{thing}Not Found", 404
        else
          error! 'Not Found', 404
        end
      end

      def forbidden!
        error! 'Forbidden', 403
      end

      def token_missing!
        error! 'Access_token is missing', 400
      end

      def token_error! code
        case code
        when 401
          error! 'invalid_token or bad request', 401
        when 403
          error! 'insuffcient_scope', 403
        when 400
          error! "Access_token is missing", 400
        end
      end
    end
  end
end
