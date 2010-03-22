class User < ActiveRecord::Base
  
  include Clearance::User
  include ActionController::UrlWriter
  
  validates_uniqueness_of :username, :message => "já esta sendo usado.", :allow_blank => true, :allow_nil => true
  validates_format_of :username, :with => /\A[a-zA-Z0-9_]*\Z/, :message => "somente são aceitos letras, numeros e '_'"
  
  is_gravtastic :secure => true, :rating => 'G'
  acts_as_voter

  before_save :cleanup_twitter
  
  has_many :quotes
  has_many :tracks
  has_many :moderation_requests
  
  #Custom attributes
  attr_accessible :name
  attr_accessible :twitter
  attr_accessible :admin
  attr_accessible :username  
  attr_accessible :bio
  
  def cleanup_twitter
    unless self.twitter.nil? || self.twitter.empty?
      self.twitter = self.twitter.scan(/(?:http\:\/\/)?(?:www\.)?(?:twitter\.com)?[\/]?(?:@)?([A-Za-z0-9_-]*)?/)[0].to_s
    end
  end
  
  def profile_url
    unless self.username.nil? || self.username.empty?
      user_profile_path(:id => self.username)
    else
      user_profile_path(:id => self.id)
    end
  end
  
  def self.find_by_num_or_id(id)
    
    if !!id.match(/\A[0-9]+\Z/)
      @user = User.find(id)
    else
      @user = User.first(:conditions => ["username = ?", id])
    end
    
    @user
  end
end