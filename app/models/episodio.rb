class Episodio < ActiveRecord::Base
  include Permissions
  
  
  validates_presence_of :numero, :titulo, :link 
  
  
  has_many :quotes, :dependent => :destroy 
  has_many :tracks, :dependent => :destroy 
end
