# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.
require "counter"

class ApplicationController < ActionController::Base
  include Clearance::Authentication
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  before_filter :username_warn

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  
  layout "geral"
  
  def authorize
    unless !current_user.nil? && current_user.admin?
      render_unauth
    end
  end
  
  def render_unauth
    render :text => 'Unauthorized', :status => :unauthorized
  end
  
  def username_warn
    flash[:notice] = 'Você não possui <b>login</b> ainda, visite seu perfil, altere seus dados e cadastre um novo login.'
  end
end
