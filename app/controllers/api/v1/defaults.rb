module API
  module V1
    module Defaults
      extend ActiveSupport::Concern

      included do
        format :json

        helpers do
          def authenticate!
            begin
              JWT.decode params[:user][:access_token], Rails.application.credentials.development[:api_hmac_secret], true, { :algorithm => 'HS256' }
              @access_token = AccessToken.where(token: params[:user][:access_token]).first
              if @access_token.present?
                @current_user = @access_token.user
              else
                error!({ success: false, message: 'Expired token.' }, 401)
              end
            rescue JWT::ExpiredSignature
              access_token = AccessToken.where(token: params[:user][:access_token]).first
              access_token.destroy if access_token.present?
              error!({ success: false, message: 'Expired token.' }, 401)
            rescue
              error!({ success: false, message: 'Invalid token' }, 401)
            end
          end
        end
      end
    end
  end
end
