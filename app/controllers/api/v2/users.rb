# frozen_string_literal: true

module API
  module V2
    class Users < API::V2::Base
      include API::Defaults

      resource :users do
        desc 'Get a user',
             headers: {
               'Authorization' => { description: Constant::AUTH_DESCRIPTION, required: true }
             }
        params do
          use :authentication_params
        end
        get ':id' do
          authenticate!
          user = User.find(params[:id])
          respond(200, UserSerializer.new(user).serializable_hash)
        end
      end
    end
  end
end
