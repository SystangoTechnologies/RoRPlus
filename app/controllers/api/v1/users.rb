module API
  module V1
    class Users < API::V1::Base
      include API::V1::Defaults

      AUTH_DESCRIPTION = "Authorization key".freeze

      helpers do
        def generate_access_token_for_user(user_id)
          @access_token = AccessToken.create(user_id: user_id)
        end

        def logout_from_existing_session(user_id)
          user = User.find(user_id)
          user.access_tokens.destroy_all
        end
      end

      resource :users do
        desc "Login for user.", {
          headers: {
            "Authorization" => {
              description: AUTH_DESCRIPTION,
              required: true
            }
          }
        }
        params do
          requires :email, type: String, desc: "Login "
          requires :password, type: String, desc: "Password"
        end
        post :login do
          @current_user = User.find_by_email(params[:email].downcase)
          if @current_user&.valid_password?(params[:password])
            logout_from_existing_session(@current_user.id)
            generate_access_token_for_user(@current_user.id)
          else
            @current_user = nil
          end
          options[:access_token] = @access_token
          {success: true, message: "Successfully logged in.", user: UserSerializer.new(@current_user, scope: options)}
        end

        desc "Signup user", {
          headers: {
            "Authorization" => {
              description: AUTH_DESCRIPTION,
              required: true
            }
          }
        }
        params do
          requires :user, type: Hash, desc: 'User object' do
            requires :first_name, type: String, desc: "First Name"
            requires :last_name, type: String, desc: "Last Name"
            requires :email, type: String, desc: "Email"
            requires :password, type: String, desc: "Password"
            requires :password_confirmation, type: String, desc: "Password Confirmation"
          end
        end
        post :sign_up, :jbuilder => "users/sign_up.json.jbuilder" do
          @current_user = User.new(params[:user])
          generate_access_token_for_user(@current_user.id) if @current_user.save
        end

        desc "Logout user", {
          headers: {
            "Authorization" => {
              description: AUTH_DESCRIPTION,
              required: true
            }
          }
        }
        params do
          requires :user, type: Hash do
            requires :access_token, type: String, desc: "Access Token"
          end
        end
        post :logout do
          authenticate!
          token = AccessToken.where(user_id: @current_user.id, token: params[:user][:access_token]).first
          token.destroy if token.present?
          { success: true, message: "Signed out successfully." }
        end
      end
    end
  end
end
