class AddAdminToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :admin, :boolean
    User.reset_column_information
  end

  def self.down
    remove_column :users, :admin
  end
end
