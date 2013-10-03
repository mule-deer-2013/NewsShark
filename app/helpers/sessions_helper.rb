module SessionsHelper

  def sign_in(user)
    if (user.guest?)
      session[:guest_id] = user.id
    else
      session[:user_id] = user.id
    end
  end

  def signed_in?
    current_user.present?
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user?(user)
    user == current_user
  end

  def current_user
    @current_user ||= 
    if session[:user_id]
      Member.find_by_id(session[:user_id])
    elsif session[:guest_id]
      Guest.find_by_id(session[:guest_id])
    end
  end

  def sign_out
    session.clear
    flash[:notice] = "You have successfully logged out."
  end
end 
