class CreateTracks < ActiveRecord::Migration
  def self.up
    create_table :tracks do |t|
      t.string :time
      t.string :song
      t.string :link
      t.references :episodio
      t.references :user

      t.timestamps
    end
  end

  def self.down
    drop_table :tracks
  end
end
