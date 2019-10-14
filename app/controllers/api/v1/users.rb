# frozen_string_literal: true

module API
  module V1
    class Users < API::V1::Base
      include API::Defaults

      resource :users do
        desc 'Create user',
             headers: {
               'Authorization' => { description: Constant::AUTH_DESCRIPTION, required: true }
             }
        params do
          requires :user, type: Hash, desc: 'User object' do
            requires :first_name, type: String, desc: 'First Name'
            requires :last_name, type: String, desc: 'Last Name'
            requires :email, type: String, desc: 'Email'
            requires :password, type: String, desc: 'Password'
            requires :password_confirmation, type: String, desc: 'Password Confirmation'
          end
        end
        post do
          user = User.new(params[:user])
          if user.save
            access_token = user.new_access_token
            header 'AccessToken', access_token.token.to_s
            respond(201, id: user.id)
          else
            respond_error(422, error_message(user))
          end
        end

        desc 'Login for user',
             headers: {
               'Authorization' => { description: Constant::AUTH_DESCRIPTION, required: true }
             }
        params do
          requires :user, type: Hash, desc: 'User object' do
            requires :email, type: String, desc: 'Email', allow_blank: false
            requires :password, type: String, desc: 'Password', allow_blank: false
          end
        end
        post :login do
          user = User.find_by_email(params[:user][:email].downcase)
          if user&.valid_password?(params[:user][:password])
            access_token = user.new_access_token
            header 'AccessToken', access_token.token.to_s
            respond(200, id: user.id)
          else
            respond_error(403, 'Invalid email or password.')
          end
        end

        desc 'Get a user',
             headers: {
               'Authorization' => { description: Constant::AUTH_DESCRIPTION, required: true }
             }
        params do
          use :authentication_params
        end
        get ':id', jbuilder: 'users/get_user.json.jbuilder' do
          authenticate!
          @user = User.find(params[:id])
        end

        desc 'Logout user',
             headers: {
               'Authorization' => { description: Constant::AUTH_DESCRIPTION, required: true }
             }
        params do
          use :authentication_params
        end
        delete :logout do
          authenticate!
          @access_token.destroy if @access_token.present?
          respond(204)
        end
      end
    end
  end
end
