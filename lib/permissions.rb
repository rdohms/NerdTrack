module Permissions
  def changeable_by?(other_user)
    return false if other_user.nil?
    user == other_user || other_user.admin?
  end
end