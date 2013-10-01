class ArticlesController < ApplicationController

  def update
    article = Article.find(params[:id])
    article.update_user_feedback(params[:user_feedback])

    article.save

    channel = article.channel
    channel.update_preferences_from(article)
    channel.save

    render 'channels/show'
  end

end
