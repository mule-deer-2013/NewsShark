class ArticleWorker

  include Sidekiq::Worker

  def perform(article_id)
    article = Article.find(article_id)
    attributes = ArticleScraper.get_article_attributes(article.url)
    # article.kincaid = attributes[:kincaid]
    # article.word_count = attributes[:word_count]
    # article.author = attributes[:author]
    # article.keywords = attributes[:keywords]
    # article.datetime = attributes[:datetime]
    # article.description = attributes[:description]
    # article.save
    # article.update_attributes( attributes )
    attributes.each do |attribute, value|
      article.update_attribute(attribute, value)
    end
  end

end
