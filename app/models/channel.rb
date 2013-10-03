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
    KARMA_WEIGHTS.keys.each do |attribute|
      if    article.respond_to?( attribute.to_sym )
        increment( attribute.to_s, article.send(attribute), article.user_feedback )
      elsif article.respond_to?( attribute.pluralize.to_sym)
        increment_array_attributes( attribute.to_s, article.send(attribute.pluralize.to_sym), article.user_feedback )
      end
    end
    # increment_keywords(article.keywords, article.user_feedback)

    # KARMA_WEIGHTS.keys.each do |attribute|
    #   unless attribute == 'keyword'
    #     increment(attribute, article.send(attribute), article.user_feedback)
    #   end

    cleanup
  end

  def cleanup
    PREFERENCED_ATTRIBUTES.each do |method|
      DELETABLES.each do |deletable|
        self.send(method).delete(deletable)
      end
    end
  end

  # private
  # keywords needs its own method since it's an array, not a single value.
  def increment_array_attributes(field, keys, value)
    keys.each do |key|
      increment( field, key, value)
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
