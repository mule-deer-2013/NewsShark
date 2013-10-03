class GuestsController < ApplicationController
  
  def create
    guest = Guest.create!
    session[:guest_id] = guest.id
    redirect_to user, :notice => "Welcome!"
  end
  
  
end
