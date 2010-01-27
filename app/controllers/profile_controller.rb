class ProfileController < ApplicationController
  
  def show
    @user = User.find_by_num_or_id(params[:id])
  end

end
