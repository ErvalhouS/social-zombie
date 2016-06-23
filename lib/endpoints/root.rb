module Endpoints
  class Root < Base
    get "/" do
      "Hello. Get information on how to use and install this platform at: https://github.com/ErvalhouS/social-zombie/"
      end

    get '/logout' do
      session["access_token"] = nil
      status 200
    end

    post '/login' do
      @current_user = Survivor.find(name: params[:name])
      if @current_user && @current_user.authenticate(params[:password])
        # if the user/pass credentials are valid, lets issue a JSON Web Token:
        headers = {
            exp: Time.now.to_i + 86400 #expire in 1 day
        }
        @current_user.generate_token!
        @token = JWT.encode([@current_user.token], settings.signing_key, "RS256", headers)

        session["access_token"] = @token
        status 200
      else
        @current_user.errors if @current_user
        halt 401
      end
    end

  end
end
