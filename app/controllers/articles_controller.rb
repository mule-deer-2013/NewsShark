class ArticlesController < ApplicationController

  def update
    article = Article.find(params[:id])
    article.user_feedback = params[:user_feedback]
    article.save
    redirect_to :back
  end

end
