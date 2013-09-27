class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.new(params[:user])
    if user.save
      redirect_to user, :notice => "Welcome!"
    else
      redirect_to new_user_path, :notice => user.errors.full_messages.join(', ')
    end
  end

  def show
    @user = User.find(params[:id])
    @channel = Channel.new
  end
end
