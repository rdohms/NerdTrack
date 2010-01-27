class User < ActiveRecord::Base
  
  include Clearance::User
  
  before_save :cleanup_twitter
  
  has_many :quotes
  has_many :tracks
  
  #Custom attributes
  attr_accessible :name
  attr_accessible :twitter
  attr_accessible :admin
  
  def cleanup_twitter
    unless self.twitter.nil? || self.twitter.empty?
      self.twitter = self.twitter.scan(/(?:http\:\/\/)?(?:www\.)?(?:twitter\.com)?[\/]?(?:@)?([A-Za-z0-9_-]*)?/)[0].to_s
    end
  end
  
  def profile_url
    unless self.twitter.nil?
      "http://www.twitter.com/"+self.twitter
    end
  end
end