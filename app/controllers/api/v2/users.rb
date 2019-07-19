# frozen_string_literal: true

module API
  module V2
    class Users < API::V2::Base
      include API::Defaults

      resource :users do
        desc 'Get a user', {
          headers: {
            'Authorization' => {
              description: Constant::AUTH_DESCRIPTION,
              required: true
            }
          }
        }
        params do
          use :authentication_params
        end
        get ":id", jbuilder: "users/get_user.json.jbuilder" do
          authenticate!
          respond_error(403) if @current_user.blank?
        end
      end
    end
  end
end
