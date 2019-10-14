# frozen_string_literal: true

module API
  module V1
    class Base < API::Base
      formatter :json, Grape::Formatter::Jbuilder
      helpers API::V1::Helpers::AuthenticationHelpers

      rescue_from ActiveRecord::RecordNotFound do
        error!('Record not found.', 404)
      end

      rescue_from ActiveRecord::InvalidForeignKey do
        error!('Unprocessable entity.', 422)
      end

      rescue_from ArgumentError do |e|
        error!(e.message.remove("'"), 422)
      end

      before do
        error!('Unauthorized request.', 401) unless authorized
      end

      helpers do
        def authorized
          authorization_key = Base64.strict_decode64(request.headers['Authorization']) rescue nil
          authorization_key == "#{$secret[:api_client_id]}:#{$secret[:api_client_secret]}"
        end
      end

      version 'v1'

      mount API::V1::Users
    end
  end
end
