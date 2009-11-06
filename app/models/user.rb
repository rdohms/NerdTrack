class User < ActiveRecord::Base
  
  include Clearance::User
  
  has_many :quotes
  has_many :tracks
  
  #Custom attributes
  attr_accessible :name
  attr_accessible :twitter
  attr_accessible :admin
end