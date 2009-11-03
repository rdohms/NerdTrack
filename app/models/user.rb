class User < ActiveRecord::Base
  
  include Clearance::User
  
  has_many :quotes
  has_many :tracks
end
