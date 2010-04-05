class ModerationRequest < ActiveRecord::Base
  
  validates_presence_of :target_id, :target_type, :user, :message => "não pode ficar em branco."
  
  belongs_to :user
  
end
