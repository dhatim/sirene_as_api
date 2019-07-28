require 'sentry-raven'
require 'gelf'

Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = true

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports.
  config.consider_all_requests_local = true

  # Enable/disable caching. By default caching is disabled.
  if Rails.root.join('tmp/caching-dev.txt').exist?
    config.action_controller.perform_caching = true

    config.cache_store = :memory_store
    config.public_file_server.headers = {
      'Cache-Control' => 'public, max-age=172800'
    }
  else
    config.action_controller.perform_caching = false

    config.cache_store = :null_store
  end

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  config.action_mailer.perform_caching = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true

  # Use an evented file watcher to asynchronously detect changes in source code,
  # routes, locales, etc. This feature depends on the listen gem.
  config.file_watcher = ActiveSupport::EventedFileUpdateChecker

  # Configure logstasher
  config.logstasher.enabled = true
  config.logstasher.suppress_app_logs = false
  config.logstasher.log_controller_parameters = true
  config.logstasher.backtrace = true



  Raven.configure do |config|
    config.dsn = ENV['SENTRY_DSN_KEY']
  end
  
  config.logger = Logger.new("#{Rails.root}/log/production.log")

  if ENV['GRAYLOG_ENABLE'] == 'true'
    options = { :facility => ENV['GRAYLOG_FACILITY'],
                :_component => ENV['GRAYLOG_COMPONENT'],
                :"_X-OVH-TOKEN" => ENV['GRAYLOG_OVH_KEY'],
                :protocol => GELF::Protocol::TCP,
               }

    if ENV['GRAYLOG_USE_TLS'] == 'true'
      options[:tls] = {'no_default_ca' => false, 'all_ciphers' => true}
    end

    graylog_logger = GELF::Logger.new(ENV['GRAYLOG_HOST'],
                                      ENV['GRAYLOG_PORT'],
                                      'WAN',
                                      options)
    # graylog_logger.level = 5
    config.logger.extend(ActiveSupport::Logger.broadcast(graylog_logger))
  end

  config.log_level = :warn
end
