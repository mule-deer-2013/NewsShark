class ArticleWorker

  include Sidekiq::Worker

  def perform(article_id)
    article = Article.find(article_id)
    attributes = ArticleScraper.get_article_attributes(article.url)
    attributes.each do |attribute, value|
      article.update_attribute(attribute, value)
    end
  end
end
