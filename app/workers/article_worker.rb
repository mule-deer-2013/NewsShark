class ArticleWorker

  include Sidekiq::Worker

  def perform(article_id)
    article = Article.find(article_id)
    attributes = ArticleScraper.get_article_attributes(article.url)
    # puts "%" * 50  
    # puts "These are the attributes"
    # puts attributes

    # puts "&" * 50 
    # puts "This is kincaid"
    # puts attributes[:kincaid]
    # puts "*" * 50
    # puts "worker"
    # puts attributes
    # puts "*" * 50
    # puts attributes[:kincaid]
    article.kincaid = attributes[:kincaid]
    article.word_count = attributes[:word_count]
    article.author = attributes[:author]
    article.keywords = attributes[:keywords]
    article.datetime = attributes[:datetime]
    article.description = attributes[:description]
    article.save
  end

end
