class Article < ActiveRecord::Base

  BLACK_LIST = ['theblaze', 'triblive', 'medscape', 'businessweek', 'outdoorlife', 'poconorecord', 'boston', 'mlb', 'cbs', 'wsj', 'reuters', 'nytimes']

  include ChannelArticleMapper

  attr_accessible :title, :url, :channel_id, :keywords, :publication, :kincaid, :datetime, :author, :word_count, :description
  validates_presence_of :title, :url
  validates_uniqueness_of :url, scope: :channel_id

  belongs_to :channel

  before_create :set_publication

  after_create :scrape_articles


  def scrape_articles
    client = IronWorkerNG::Client.new(:token => ENV['TOKEN'], :project_id => ENV['PROJECT_ID'])
    client.task.create('article_workers', {'project_id' => self.id}, 'database' => Rails.configuration.database_configuration[Rails.env])
  end

  def set_publication
    publication = self.url.sub(/^https?:\/\/(www\.)?/, '')
    self.publication = publication.sub(/(.com||.org(.eg)?||.net)?\/.*$/, '')
    check_blacklist
  end

  def compute_closeness
    channel = self.channel
    closeness = 0
    ATTRIBUTE_MAPPER.each_pair do |channel_preferences, article_attribute|
      channel.send(channel_preferences).each_pair do |channel_preference, karma|
        if (channel_preference.to_s.in?(self.send(article_attribute).to_s) &&
             karma.to_f.abs >= channel.minimum_karma_for_relevancy )
          closeness += karma.to_f
        end
      end
    end

    closeness
  end

  def check_blacklist
    BLACK_LIST.each do |black|
      self.destroy if self.publication.include?(black)
    end
  end
end
