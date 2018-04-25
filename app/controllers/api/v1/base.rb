module API
  module V1
    class Base < API::Base
      # This method is allow access to the appication header contains the valid app secrets and id
      before do
        error!({ success: false, message: 'Invalid authorization key' }, 401) unless authorized
        status 200
      end

      helpers do
        def authorized
          # cm9yX3BsdXM6SERGa2ZSb3JQbHVzNjQ1
          authorization_key = Base64.strict_decode64(request.headers['Authorization']) rescue false
          authorization_key == "#{Rails.application.credentials.development[:api_client_id]}:#{Rails.application.credentials.development[:api_client_secret]}"
        end
      end

      version 'v1', using: :header, vendor: 'users'
      format :json
      formatter :json, Grape::Formatter::Jbuilder
      mount API::V1::Users
    end
  end
end
