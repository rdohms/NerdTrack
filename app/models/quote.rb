class Quote < ActiveRecord::Base

  validates_presence_of :quote, :time, :episodio, :user
  
  belongs_to :episodio
  belongs_to :user
end
