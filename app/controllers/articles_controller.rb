class ArticlesController < ApplicationController

  def update
    article = Article.find(params[:id])
    article.user_feedback = params[:user_feedback]
    article.save

    channel = article.channel
    channel.update_preferences_from(article)
    channel.save

    user = channel.user

    redirect_to user_channel_path(user, channel)
  end

end
