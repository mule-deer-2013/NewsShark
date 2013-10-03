class UsersController < ApplicationController
  skip_before_filter :require_login, only: [:new, :create]


  # def new
  #   @member = Member.new
  # end



  # def create
  #   @member = Member.new(params[:member])
  #   if @member.save
  #     current_user.move_to(@member) if current_user && current_user.guest?
  #     sign_in member
  #     redirect_to member_path(member.id)
  #   else
  #     redirect_to new_user_path, :notice => user.errors.full_messages.join(', ')
  #   end
  # end



  def new
    @user = User.new
  end

  def create
    # debugger
    if(params[:type] == "guest")
      user = Guest.new(params[:user])
      # debugger
    else
      user = Member.new(params[:user])
    end
    if user.save
      sign_in user
      redirect_to user_path(user.id), :notice => "Welcome!"
    else
      redirect_to new_user_path, :notice => user.errors.full_messages.join(', ')
    end
  end

  def show
    @user = current_user
    @channel = Channel.new
    @user_channels = @user.channels
  end
end
