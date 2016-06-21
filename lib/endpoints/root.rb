module Endpoints
  class Root < Base
    get "/" do
      "Hello. Get information on how to user and install this platform at: https://github.com/ErvalhouS/social-zombie/"
      "Get schema information and use cases at: https://github.com/ErvalhouS/social-zombie/blob/master/schema.md"
      end

    get '/login' do
      erb :login
    end

    get '/logout' do
      session["access_token"] = nil
      redirect to("/")
    end

    post '/login' do
      @current_user = Survivor.find(name: params[:name])
      if @current_user && @current_user.authenticate(params[:password])
        # if the user/pass credentials are valid, lets issue a JSON Web Token:
        headers = {
            exp: Time.now.to_i + 86400 #expire in 1 day
        }

        @token = JWT.encode({token: @current_user.generate_token!}, settings.signing_key, "RS256", headers)

        session["access_token"] = @token
        redirect to("/")
      else
        @current_user.errors if @current_user
        halt 401
      end
    end

  end
end
