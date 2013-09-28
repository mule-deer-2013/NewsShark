class ChannelsController < ApplicationController
  def create
    channel = Channel.new(params[:channel])
    channel.user = User.find(params[:user_id])
    if channel.save
      @channel = Channel.find(params[:id])
      @articles = @channel.articles
      redirect_to user_channel_path(channel.user, channel)
    else
      flash[:notice] = channel.errors.full_messages.join(', ')
      redirect_to channel.user
    end
  end


  def show
    @channel = Channel.find(params[:id])
    @articles = @channel.articles
  end

end
