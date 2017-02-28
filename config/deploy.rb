require 'mina/rails'
require 'mina/git'
require 'mina/rbenv'  # for rbenv support. (https://rbenv.org)
# require 'mina/rvm'    # for rvm support. (https://rvm.io)

# Basic settings:
#   domain       - The hostname to SSH to.
#   deploy_to    - Path to deploy into.
#   repository   - Git repo to clone from. (needed by mina/git)
#   branch       - Branch name to deploy. (needed by mina/git)

set :application_name, 'alderhilldigital.co.uk'
set :domain, 'ec2-34-249-65-184.eu-west-1.compute.amazonaws.com'
set :deploy_to, '/var/app/alderhilldigital.co.uk'
set :repository, 'https://github.com/alderhilldigital/alderhilldigital.co.uk.git'
set :branch, 'master'
set :rails_env, 'production'

# Optional settings:
#   set :user, 'foobar'          # Username in the server to SSH to.
#   set :port, '30000'           # SSH port number.
#   set :forward_agent, true     # SSH forward_agent.
set :user, 'ubuntu'                # Optional
set :identity_file, '/Users/alanstirling/Dropbox/web1.pem'
set :forward_agent, true     # SSH forward_agent.
set :port, '22'

# shared dirs and files will be symlinked into the app-folder by the 'deploy:link_shared_paths' step.
# set :shared_dirs, fetch(:shared_dirs, []).push('somedir')
# set :shared_files, fetch(:shared_files, []).push('config/database.yml', 'config/secrets.yml')

# This task is the environment that is loaded for all remote run commands, such as
# `mina deploy` or `mina rake`.
task :environment do
  # If you're using rbenv, use this to load the rbenv environment.
  # Be sure to commit your .ruby-version or .rbenv-version to your repository.
  invoke :'rbenv:load'

  # For those using RVM, use this to load an RVM version@gemset.
  # invoke :'rvm:use', 'ruby-1.9.3-p125@default'
end

# Put any custom commands you need to run at setup
# All paths in `shared_dirs` and `shared_paths` will be created on their own.
task :setup do
  # command %{rbenv install 2.3.0}
end

task :env do
  command %{
    echo "-----> Loading environment"
    #{File.read("/webapps/alderhill/env_vars")}
  }
end

desc "Deploys the current version to the server."
task :deploy do
  # uncomment this line to make sure you pushed your local branch to the remote origin
  # invoke :'git:ensure_pushed'
  invoke :'env'


  deploy do
    # Put things that will set up an empty directory into a fully set-up
    # instance of your project.
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    invoke :'rails:db_migrate'
    invoke :'rails:assets_precompile'
    invoke :'deploy:cleanup'

    on :launch do
      in_path(fetch(:current_path)) do
        command %{mkdir -p tmp/}
        command %{touch tmp/restart.txt}
      end
    end

    #invoke :'unicorn:restart'
  end

  # you can use `run :local` to run tasks on local machine before of after the deploy scripts
  #run(:local){ say 'done' }
end

namespace :unicorn do
  set :app_path, "/var/app/#{fetch(:application_name)}/current"
  set :shared_path, "/var/app/#{fetch(:application_name)}/shared"
  set :unicorn_pid, "#{fetch(:shared_path)}/pids/unicorn.pid"

  #                                                                    Start task
# ------------------------------------------------------------------------------
  desc "Start unicorn"
  task :start => :environment do
    command 'echo "-----> Start Unicorn"'
    command %{
      cd #{fetch(:app_path)}
      bundle exec unicorn -c config/unicorn.rb -E #{fetch(:rails_env)} -D
    }
  end

#                                                                     Stop task
# ------------------------------------------------------------------------------
  desc "Stop unicorn"
  task :stop do
    command 'echo "-----> Stop Unicorn"'
    command %{
      test -s "#{fetch(:unicorn_pid)}" && kill -QUIT `cat "#{fetch(:unicorn_pid)}"` && echo "Stop Ok"
      echo >&2 "Not running"
    }
  end

#                                                                  Restart task
# ------------------------------------------------------------------------------
  desc "Restart unicorn using 'upgrade'"
  task :restart => :environment do
    invoke 'unicorn:stop'
    invoke 'unicorn:start'
  end
end



# For help in making your deploy script, see the Mina documentation:
#
#  - https://github.com/mina-deploy/mina/tree/master/docs
