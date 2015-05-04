# config valid only for current version of Capistrano
lock '3.3.5'

set :application, 'email_push'
set :repo_url, 'git@gitcafe.com:sz3001/email_push.git'

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, '/var/www/my_app_name'
set :branch,'master'

set :deploy_to, '/var/www/email_push'

set :bundle_flags, '--deployment'

set :bundle_gemfile, -> { release_path.join('Gemfile') }



# Default value for :scm is :git
set :scm, :git

set :chruby_ruby, 'ruby-2.2.1'

set :bundle_binstubs, nil

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
set :linked_files, fetch(:linked_files, []).push('config/database.yml','config/settings.yml','config/boot_app.yml')

# Default value for linked_dirs is []
set :linked_dirs, fetch(:linked_dirs, []).push('bin', 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system','public/uploads')

# Default value for default_env is {}
set :default_env, { path: "/opt/rubies/ruby-2.1.2/bin:$PATH" }

# Default value for keep_releases is 5
set :keep_releases, 5

namespace :deploy do

  task :boot_sidekiq do
    on roles(:web), in: :sequence, wait: 3 do
      within release_path do
        execute "./closedsidekiq"
        execute :bundle,"exec sidekiq -e production -d -L log/sidekiq.log"
      end
    end
  end

  task :restart_thin  do
    on roles(:web),in: :sequence, wait: 3 do
      within release_path do
        execute :bundle,"exec rake kindeditor:assets"
        execute :bundle,"exec thin restart -C /var/www/email_push/shared/config/boot_app.yml"
      end
    end

  end

  after :published, :boot_sidekiq

  after :published, :restart_thin


end
