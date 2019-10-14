# This file is used by Rack-based servers to start the application.

require_relative 'config/environment'

use Rack::Config do |env|
  env['api.tilt.root'] = "#{Rails.root}/app/views/api/"
end

run Rails.application
