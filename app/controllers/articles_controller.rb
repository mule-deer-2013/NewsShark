class ArticlesController < ApplicationController

  def update
    article = Article.find(params[:id])
    article.user_feedback = params[:user_feedback]
    article.save

    if article.user_feedback == 1
      article.channel.preference.set_keywords_from(article)
    end

    redirect_to :back
  end

end
