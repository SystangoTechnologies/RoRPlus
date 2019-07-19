# frozen_string_literal: true

module API
  module Defaults
    extend ActiveSupport::Concern

    included do
      helpers do
        def authenticate!
          begin
            JWT.decode(params[:user][:access_token], $secret[:api_hmac_secret], true, { :algorithm => 'HS256' })
            @access_token = AccessToken.where(token: params[:user][:access_token]).first
            if @access_token.present?
              @current_user = @access_token.user
            else
              respond_error(401, 'Invalid session.')
            end
          rescue JWT::ExpiredSignature
            access_token = AccessToken.where(token: params[:user][:access_token]).first
            access_token.destroy if access_token.present?
            respond_error(401, 'Session expired.')
          rescue
            respond_error(401, 'Invalid session.')
          end
        end

        def error_message(object)
          object.errors.full_messages.uniq.join(",")
        end

        def respond(code = nil, data = nil)
          status code if code
          body data if data
        end

        def respond_error(code = nil, message = '')
          error!(message, code)
        end
      end
    end
  end
end
