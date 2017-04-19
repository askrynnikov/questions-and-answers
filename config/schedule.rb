# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron


job_type :rbenv_rake, %Q{export PATH=/home/deploy/.rbenv/shims:/home/deploy/.rbenv/bin:/usr/bin:$PATH; eval "$(rbenv init -)"; \
                         cd :path && :environment_variable=:environment :bundle_command rake :task --silent :output }

job_type :rbenv_runner, %Q{export PATH=/home/deploy/.rbenv/shims:/home/deploy/.rbenv/bin:/usr/bin:$PATH; eval "$(rbenv init -)"; \
                         cd :path && :bundle_command :runner_command -e :environment ':task' :output }

# job_type :runner,  "cd :path && :bundle_command :runner_command -e :environment ':task' :output"


# job_type :command, ":task :output"
# job_type :rake,    "cd :path && :environment_variable=:environment :bundle_command rake :task --silent :output"
# job_type :script,  "cd :path && :environment_variable=:environment :bundle_command script/:task :output"
# job_type :runner,  "cd :path && :bundle_command :runner_command -e :environment ':task' :output"

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

every 1.day, at: '11:59pm' do
  # runner 'DailyDigestJob.perform_now'
  rbenv_runner 'DailyDigestJob.perform_now'
end

every 60.minutes do
# every '7 * * * *' do
  # rake "ts:index"
  rbenv_rake "ts:index"
end

# * * * * * /bin/bash -l -c 'cd /home/deploy/qna/releases/20170419121426 && bundle exec bin/rails runner -e production '\''DailyDigestJob.perform_now'\'''

# * * * * * /bin/bash -l -c 'cd /home/deploy/qna/releases/20170419121426 && RAILS_ENV=production bundle exec rake ts:index --silent'


# Learn more: http://github.com/javan/whenever

