threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }
threads threads_count, threads_count

# Specifies the `port` that Puma will listen on to receive requests; default is 3000.
port        ENV.fetch("PORT") { 3000 }

# Specifies the `environment` that Puma will run in.
environment ENV.fetch("RAILS_ENV") { "development" }

unless ENV.fetch("RAILS_ENV") == 'development'
  workers 2
  app_dir = File.expand_path("../..", __FILE__)

  daemonize true
  shared_dir = "#{app_dir}/shared/"

  # Set up socket location
  bind "unix://#{shared_dir}tmp/sockets/puma.sock"

  # Logging
  stdout_redirect "#{shared_dir}log/puma.stdout.log", "#{shared_dir}log/puma.stderr.log", true

  # Set master PID and state locations
  pidfile "#{shared_dir}tmp/pids/puma.pid"
  state_path "#{shared_dir}tmp/pids/puma.state"

  activate_control_app
end

# Allow puma to be restarted by `rails restart` command.
plugin :tmp_restart

unless ENV.fetch("RAILS_ENV") == 'development'
  on_worker_boot do
    require "active_record"
    ActiveRecord::Base.connection.disconnect! rescue ActiveRecord::ConnectionNotEstablished
    ActiveRecord::Base.establish_connection(YAML.load_file("#{app_dir}/config/database.yml")[ENV.fetch("RAILS_ENV")])
  end
end
