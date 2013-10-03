class ChannelsController < ApplicationController
  def create
    channel = Channel.new(params[:channel])
    channel.user = User.find(params[:user_id])
    if channel.save
      redirect_to user_channel_path(channel.user, channel)
    else
      flash[:notice] = channel.errors.full_messages.join(', ')
      redirect_to channel.user
    end
  end

  def show
    @channel = Channel.find(params[:id])
    if @channel.user == current_user
      best_articles = Recommender.best_articles_ranked(@channel.id)
      @articles = ( best_articles.empty? ? @channel.unrated_articles : best_articles )
    else
      render status: 401, text: "<h1>401 Unauthorized</h1>"
    # JW: Look into can-can if you want to fine-tune authorization.
    end
  end

  def destroy
    channel = Channel.find(params[:id])
    channel.user == current_user ? channel.destroy : "You cannot delete this channel"
    redirect_to user_path current_user
  end
end
