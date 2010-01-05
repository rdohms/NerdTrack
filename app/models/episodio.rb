class Episodio < ActiveRecord::Base
  include Permissions
  
  def to_param  # overridden
    if parte.nil?
      numero.to_s
    else
      numero.to_s+parte
    end
  end
  
  validates_presence_of :numero, :titulo, :link 
  
  
  has_many :quotes, :dependent => :destroy, :order => "time ASC" 
  has_many :tracks, :dependent => :destroy, :order => "time ASC"
end
