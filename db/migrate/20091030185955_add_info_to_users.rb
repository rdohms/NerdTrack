class AddInfoToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :name, :string
    add_column :users, :twitter, :string
    User.reset_column_information
  end

  def self.down
    remove_column :users, :twitter
    remove_column :users, :name
  end
end
