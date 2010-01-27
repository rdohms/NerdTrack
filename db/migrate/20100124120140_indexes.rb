class Indexes < ActiveRecord::Migration
  def self.up
    add_index :users, :username, :unique => true
    add_index :tracks, :user_id
    add_index :quotes, :user_id
  end

  def self.down
    remove_index :users, :username
    remove_index :tracks, :user_id
    remove_index :quotes, :user_id
  end
end
