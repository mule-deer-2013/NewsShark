class UsersController < ApplicationController
  skip_before_filter :require_login, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    user = User.new(params[:user])
    if user.save
      sign_in user
      redirect_to user, :notice => "Welcome!"
    else
      redirect_to new_user_path, :notice => user.errors.full_messages.join(', ')
    end
  end

  def show
    @user =  current_user
    @channel = Channel.new
  end
end
