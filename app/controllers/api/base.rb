# frozen_string_literal: true

module API
  class Base < Grape::API
    mount API::V1::Base
    mount API::V2::Base

    add_swagger_documentation mount_path: '/api_docs', api_version: 'v1',
      info: {
        title: "RorPlus API's",
        description: "API's available for RorPlus users"
      }
  end
end
