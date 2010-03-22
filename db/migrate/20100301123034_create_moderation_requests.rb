class CreateModerationRequests < ActiveRecord::Migration
  def self.up
    create_table :moderation_requests do |t|
      t.integer :target_id
      t.string :target_type
      t.text :reason
      t.string :category
      t.references :user

      t.timestamps
    end
  end

  def self.down
    drop_table :moderation_requests
  end
end
