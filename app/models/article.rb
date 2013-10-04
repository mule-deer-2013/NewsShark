class Article < ActiveRecord::Base

  BLACK_LIST = ['theblaze', 'triblive', 'medscape', 'businessweek', 'outdoorlife', 'poconorecord', 'boston', 'mlb', 'cbs', 'wsj', 'reuters', 'nytimes']

  include ChannelArticleMapper

  attr_accessible :title, :url, :channel_id, :keywords, :publication, :kincaid, :datetime, :author, :word_count, :description
  validates_presence_of :title, :url
  validates_uniqueness_of :url, scope: :channel_id

  belongs_to :channel

  before_create :set_publication
  
  after_create { ArticleWorker.perform_async(self.id) }

  def set_publication
    publication = self.url.sub(/^https?:\/\/(www\.)?/, '')
    self.publication = publication.sub(/(.com||.org(.eg)?||.net)?\/.*$/, '')
    check_blacklist
  end

  def compute_closeness
    channel = self.channel
    closeness = 0
    ATTRIBUTE_MAPPER.each_pair do |channel_attrs, article_attr|
      channel.send(channel_attrs).each_pair do |channel_attr, karma|
        if ( channel_attr.to_s.in?(self.send(article_attr).to_s) && karma.to_f.abs >= channel.minimum_karma_for_relevancy )
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
