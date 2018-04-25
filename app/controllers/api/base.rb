module API
  class Base < Grape::API
    format :json
    prefix 'api'
    mount API::V1::Base
    add_swagger_documentation mount_path: '/api_docs', api_version: 'v1',
      info: {
        title: "RorPlus API's",
        description: "API's available for RorPlus users"
      }
  end
end
