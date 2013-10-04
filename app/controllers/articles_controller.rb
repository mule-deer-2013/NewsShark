class ArticlesController < ApplicationController

  def update
    article = Article.find(params[:id])
    channel = article.channel
    user = channel.user

    article.user_feedback = params[:user_feedback]
    article.save

    channel.update_preferences_from(article)
    channel.save

    best_articles = Recommender.best_articles_ranked(channel.id)
    next_article = ( best_articles.empty? ? channel.unrated_articles.first : best_articles.first )

    partial = render_to_string(:partial => 'articles/feedback_form', locals: { article: next_article })

    respond_to do |format|
      format.json { render json: {url: next_article.url , feedback_partial: partial} }
    end
  end

  def show
    render :json => render_to_string(:partial => 'articles/feedback_form', locals: { article: Article.find(params[:id]) }).to_json
  end

end