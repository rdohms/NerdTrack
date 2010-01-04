class AddPartToEpisodio < ActiveRecord::Migration
  def self.up
    add_column :episodios, :parte, :string
  end

  def self.down
    remove_column :episodios, :parte
  end
end
