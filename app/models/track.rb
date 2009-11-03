class Track < ActiveRecord::Base

  validates_presence_of :time, :song, :episodio, :user
  
  belongs_to :episodio
  belongs_to :user
end
