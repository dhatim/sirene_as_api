# Learn more: http://github.com/javan/whenever
set :output, File.join(Whenever.path, 'log', 'sirene_api_cron.log')
set :chronic_options, hours24: true

# environment var is set with
# whenever --set 'environment=VALUE'
# which is set by Mina/whenver with RAILS_ENV

# till finding a better way to fix crontab not using the right version of rake
ENV.each { |k, v| env(k, v) }

###### SANDBOX ######
if environment == 'sandbox'
  every 2.days, at: '8:00 am' do
    rake 'sirene_as_api:automatic_update_database'
  end
end

###### PRODUCTION ######
if environment == 'production'
  # CRON Job for single server update, uncomment if you have a single server

  time = ENV['AUTO_UPDATE_TIME'] ? ENV['AUTO_UPDATE_TIME'] : '0:00'
  every 1.day, at: time do
    rake 'sirene_as_api:automatic_update_database'
  end

  # CRON jobs for dual server update, comment out if you have a single server
  # The rake task is launched only if the server is not used, so each server will update every other day
  every 1.day, at: '4:30 am' do
    rake 'sirene_as_api:dual_server_update'
  end

  every :weekend, at: '1:00 am' do
    rake "-s sitemap:refresh:no_ping"
  end
end
