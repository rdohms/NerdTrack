# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)

#Create Default Admin
admin = User.create( :email => 'admin@nerdtracker.rafaeldohms.com.br', 
                     :password => 'n3rdt', 
                     :password_confirmation => 'n3rdt', 
                     :admin => 1,
                     :name => 'NerdBot',
                     :twitter => 'nerdtracker'
                  )
admin.confirm_email!