module Pliny
  module Helpers
    module Auth

      # protected just does a redirect if we don't have a valid token
      def protected!
        return if authorized?
        halt 401
      end

      def extract_token
        # helper to extract the token from the session, header or request param# if we are building an api, we would obviously want to handle header or request paramdef extract_token
        # check for the access_token header
        token = request.env["access_token"]

        if token
          return token
        end

        # or the form parameter _access_token
        token = request["access_token"]

        if token
          return token
        end

        # or check the session for the access_token
        token = session["access_token"]

        if token
          return token
        end

        nil
      end

      # check the token to make sure it is valid with our public key
      def authorized?
        @user_id = nil
        @token = extract_token
        begin
          payload, header = JWT.decode(@token, settings.verify_key, true)

          @exp = header["exp"]

          # check to see if the exp is set (we don't accept forever tokens)
          if @exp.nil?
            puts "Access token doesn't have exp set"
            return false
          end

          @exp = Time.at(@exp.to_i)

          # make sure the token hasn't expired
          if Time.now > @exp
            puts "Access token expired"
            return false
          end

          @user_id = payload[0]

        rescue JWT::DecodeError => e
          return false
        end
        true
      end
      def current_user
        Survivor.find(token: @user_id)
      end
    end
  end
end
