
set :user, 'rdohms'  # Your dreamhost account's username
set :domain, 'nerdtrack.com.br'  # Dreamhost servername where your account is located 
set :project, 'nerdtracker'  # Your application as its called in the repository
set :application, 'nerdtrack.com.br'  # Your app's location (domain or sub-domain name as setup in panel)
set :applicationdir, "/home/#{user}/#{application}"  # The standard Dreamhost setup

# version control config
set :scm_username, 'rdohms'
set :scm_password, 'YOUR_SVN_PASSWORD'
set :repository, "https://svn.rafaeldohms.com.br/nerdtracker/trunk"

# roles (servers)
role :web, domain
role :app, domain
role :db,  domain, :primary => true

# deploy config
set :deploy_to, applicationdir
set :deploy_via, :export

# additional settings
default_run_options[:pty] = true  # Forgo errors when deploying from windows
#ssh_options[:keys] = %w(/Path/To/id_rsa)            # If you are using ssh_keys
set :chmod755, "app config db lib public vendor script script/* public/disp*"
set :use_sudo, false

after 'deploy:update_code', 'deploy:symlink_db'

namespace :deploy do
  desc "Symlinks the database.yml"
  task :symlink_db, :roles => :app do
    run "ln -nfs #{deploy_to}/config/environments/sensible/database.yml #{release_path}/config/database.yml"
  end
end
