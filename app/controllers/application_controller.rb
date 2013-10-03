class ApplicationController < ActionController::Base
  include SessionsHelper
  protect_from_forgery

  before_filter :require_login

  private
  def require_login
    unless signed_in?
      redirect_to new_user_path
    end
  end
end
