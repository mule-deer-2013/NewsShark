class Channel < ActiveRecord::Base
  serialize :preferenced_keywords, ActiveRecord::Coders::Hstore

  attr_accessible :name, :user_id, :preferenced_keywords

  validates_presence_of :name

  belongs_to :user
  has_many :articles


  def scrape_for_articles
    articles = NewsScraper.scrape(self.name)

    articles.each_pair do |title, url|
      begin
        article = self.articles.create(title: title, url: url)
        if article.valid?
          ArticleWorker.perform_async(article.id)
        end
      rescue
      end
    end
  end


  def update_preferences_from(article)
    increment_values_for(article.keywords, article.user_feedback)
  end

  private

  def increment_values_for(keywords, user_feedback)
    keywords.each do |keyword|
      self.preferenced_keywords[keyword] = self.preferenced_keywords[keyword].to_i + user_feedback
    end
  end

end
