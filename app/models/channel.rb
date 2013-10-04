class Channel < ActiveRecord::Base

  include ChannelArticleMapper

  attr_accessible :name, :user_id

  validates_presence_of :name

  PREFERENCED_ATTRIBUTES.each do |attribute|
    serialize attribute, ActiveRecord::Coders::Hstore
  end

  belongs_to :user
  has_many :articles, dependent: :destroy

  after_create :scrape_for_articles

  def unrated_articles
    self.articles.where(user_feedback: nil)
  end

  def rated_articles
    self.articles - self.articles.where(user_feedback: nil)
  end

  def minimum_karma_for_relevancy
    self.rated_articles.count/KARMA_SCALING_FACTOR
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
    increment_keywords(article.keywords, article.user_feedback)
    increment('publication', article.publication, article.user_feedback)
    cleanup
  end

  def cleanup
    PREFERENCED_ATTRIBUTES.each do |method|
      self.send(method).delete('nil')
      self.send(method).delete(nil)
      self.send(method).delete('')
    end
  end

  # private
  # keywords needs its own method since it's an array, not a single value.
  def increment_keywords(keywords, user_feedback)
    keywords.each do |keyword|
      increment('keyword', keyword, user_feedback)
    end
  end

  def increment(field, key, value)
    preferenced_ = "preferenced_#{field}s"
    setter = preferenced_.to_sym
    self.send(setter)[key] = ( self.send(setter)[key].to_f ) + ( value.to_f * KARMA_WEIGHTS[field] )
    # This becomes attr => karma used in article.rb
  end

  # JW: Consider having just one "preferences" field of type "text" in the database
  #     and using JSON to serialize the structured data

end