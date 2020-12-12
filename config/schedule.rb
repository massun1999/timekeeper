# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

require File.expand_path(File.dirname(__FILE__) + "/environment")


rails_env = ENV['RAILS_ENV'] || :development


set :environment, rails_env
set :output, "#{Rails.root}/log/cron.log"
set :job_template, "/bin/zsh -l -c ':job'"
job_type :rake, "export PATH=\"$HOME/.rbenv/bin:$PATH\"; eval \"$(rbenv init -)\"; cd :path && RAILS_ENV=:environment bundle exec rake :task :output"

every 1.day, at: ['9:50 am'] do 
  rake 'push_line:push_line_message_prepare'
end

every 1.day, at: ['10:00 am'] do
  rake 'push_line:push_line_message_start'
end

every 1.day, at: ['1:00 pm'] do
  rake 'push_line:push_line_message_afternoon'
end

every 1.day, at: ['6:00 pm'] do
  rake 'push_line:push_line_message_finish'
end

every 1.day, at: ['6:10 pm'] do
  rake 'push_line:push_line_message_dayout'
end