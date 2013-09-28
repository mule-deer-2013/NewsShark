class ApplicationController < ActionController::Base
  include SessionsHelper
  protect_from_forgery

  before_filter :require_login
 
  private
 
  def require_login
    unless signed_in?
      redirect_to signin_path, :notice => "You must be logged in to access this section" 
    end
  end
end
