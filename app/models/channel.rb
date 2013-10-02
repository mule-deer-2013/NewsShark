class Channel < ActiveRecord::Base

  attr_accessible :name, :user_id, :preferenced_keywords

  validates_presence_of :name

  serialize :preferenced_publications, ActiveRecord::Coders::Hstore
  serialize :preferenced_keywords, ActiveRecord::Coders::Hstore

  belongs_to :user

  has_many :articles, dependent: :destroy

  after_create :scrape_for_articles

  SCALING_FACTOR = 10.0

  def unrated_articles
    self.articles.where(user_feedback: nil)
  end

  def rated_articles
    self.articles - self.articles.where(user_feedback: nil)
  end

  def minimum_karma_for_relevancy
    self.rated_articles.count/SCALING_FACTOR
  end

  def scrape_for_articles
    articles = NewsScraper.scrape(self.name)
    articles.each_pair do |title, url|
      begin
        article = self.articles.create(title: title, url: url)
      rescue
      end
    end
  end

  def update_preferences_from(article)
    increment_publications(article.publication, article.user_feedback)
    increment_keywords(article.keywords, article.user_feedback)
  end

  private
  def increment_publications(publication, user_feedback)
    increment('publication', publication, user_feedback)
  end

  def increment_keywords(keywords, user_feedback)
    keywords.each do |keyword|
      increment('keyword', keyword, user_feedback)
    end
  end

  def increment(field, key, value)
    preferenced_ = "preferenced_#{field}s"
    setter = preferenced_.to_sym
    self.send(setter)[key] = self.send(setter)[key].to_i + value.to_i
  end

end
