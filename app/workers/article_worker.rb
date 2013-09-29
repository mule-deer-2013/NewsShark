class ArticleWorker
  include Sidekiq::Worker

  def perform(article_id)
    article = Article.find(article_id)
    article.set_keywords
  end
end