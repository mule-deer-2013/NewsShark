class ArticlesController < ApplicationController

  def update
    article = Article.find(params[:id])
    channel = article.channel
    user = channel.user

    article.user_feedback = params[:user_feedback]
    article.save

    channel.update_preferences_from(article)
    channel.save

    redirect_to user_channel_path(user, channel)
  end

end
