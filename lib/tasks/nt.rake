namespace :nt do
  namespace :fix do
    desc "Fixes Twitter entries by re-saving users and going through before_save methods"
    task :twitter => :environment do
      @users = User.find(:all)
      @users.each do |u|
        u.save
      end
    end
  end
end