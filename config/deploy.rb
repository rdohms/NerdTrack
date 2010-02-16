
set :user, 'rdohms'  # Your dreamhost account's username
set :domain, 'nerdtrack.com.br'  # Dreamhost servername where your account is located 
set :project, 'nerdtracker'  # Your application as its called in the repository
set :application, 'nerdtrack.com.br'  # Your app's location (domain or sub-domain name as setup in panel)
set :deploy_to, "/home/#{user}/#{application}"

#Define Environment
set :default_env,  'staging'
set :rails_env,     ENV['rails_env'] || ENV['RAILS_ENV'] || default_env

# version control config
if rails_env == "staging"
  set :repository, "https://rdohms@svn.rafaeldohms.com.br/nerdtracker/tags/demo"
else
  set :repository, "https://rdohms@svn.rafaeldohms.com.br/nerdtracker/tags/current"
end

# roles (servers)
role :web, domain
role :app, domain
role :db,  domain, :primary => true

# deploy config

set :deploy_via, :export

# additional settings
default_run_options[:pty] = true  # Forgo errors when deploying from windows
#ssh_options[:keys] = %w(/Path/To/id_rsa)            # If you are using ssh_keys
set :chmod755, "app config db lib public vendor script script/* public/disp*"
set :use_sudo, false

#Change Env Setting
after 'deploy:update_code', 'deploy:migrate_env'
namespace :deploy do
  desc "Alter the environment according to plan"
  task :migrate_env do
    run "sed -i 's/RAILS_ENV = \"[a-z]*\"/RAILS_ENV = \""+rails_env+"\"/' #{release_path}/config/environment.rb"
  end
end

#Configure Sym Link for DB config
after 'deploy:update_code', 'deploy:symlink_config'
namespace :deploy do
  desc "Symlinks the config files"
  task :symlink_config, :roles => :app do
    run "ln -nfs #{deploy_to}/app/share/config/database.yml  #{release_path}/config/database.yml"
    run "ln -nfs #{deploy_to}/app/share/config/"+rails_env+".rb #{release_path}/config/environments/sensible/"+rails_env+".rb"
  end
end

#Install Gems DB
after 'deploy:symlink_config', 'deploy:migrate_db'
namespace :deploy do
  desc "Alter the environment according to plan"
  task :migrate_db  do
    run "cd #{release_path} && rake gems:install"
  end
end

#Migrate DB
after 'deploy:symlink_config', 'deploy:migrate_db'
namespace :deploy do
  desc "Alter the environment according to plan"
  task :migrate_db  do
    run "cd #{release_path} && rake RAILS_ENV="+rails_env+" db:migrate"
  end
end

#Adjust robots
after 'deploy:migrate_db', 'deploy:adjust_robots'
namespace :deploy do
  desc "Alter the robots.txt for demo env so it does not let anyone in"
  task :adjust_robots  do
    if rails_env == "staging"
      run "echo User-agent: \\* > #{release_path}/public/robots.txt"
      run "echo Disallow: / >> #{release_path}/public/robots.txt"
    end
  end
end
