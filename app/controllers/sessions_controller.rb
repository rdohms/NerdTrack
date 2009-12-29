class SessionsController < Clearance::SessionsController 

  private 

  def url_after_create
    root_url
  end

  def flash_success_after_destroy
    flash[:success] = translate(:signed_out, :default =>  "Signed out.")
  end

  def url_after_destroy
    root_url
  end

end