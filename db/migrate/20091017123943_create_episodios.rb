class CreateEpisodios < ActiveRecord::Migration
  def self.up
    create_table :episodios do |t|
      t.integer :numero
      t.string :titulo
      t.string :imagem
      t.text :desc
      t.string :link

      t.timestamps
    end
  end

  def self.down
    drop_table :episodios
  end
end
