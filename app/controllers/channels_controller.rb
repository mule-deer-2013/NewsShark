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
    @channel.scrape_for_articles
    best_articles = Recommender.best_articles_ranked(@channel.id)
    @articles = ( best_articles.empty? ? @channel.articles : best_articles )
  end

  def destroy
    channel = Channel.find(params[:id])
    channel.user == current_user ? channel.destroy : "You cannot delete this channel"
    redirect_to user_path current_user
  end
end
