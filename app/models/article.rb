class Article < ActiveRecord::Base

  include MetaInspector

  attr_accessible :title, :url, :channel_id, :keywords
  belongs_to :channel
  validates_presence_of :title, :url
  validates_uniqueness_of :url, scope: :channel_id
  before_create :set_publication
  after_create do
    ArticleWorker.perform_async(self.id)
  end

  def set_publication
    publication = self.url.sub(/^https?:\/\/(www\.)?/, '')
    self.publication = publication.sub(/(.com||.org(.eg)?||.net)?\/.*$/, '')
  end

  # JW: this seems like a bad idea
  def update_user_feedback!(value)
    self.user_feedback = value unless self.user_feedback == value
    self.save
  end

  def compute_closeness
    closeness = 0
    channel = self.channel
    # when we use attributes this will be channel.send(attribute)
    channel.preferenced_keywords.each_pair do |term, karma|
      if (term.in?(self.keywords) && karma.to_i.abs >= channel.minimum_karma_for_relevancy)
        closeness += karma.to_i
      end
    end

    closeness
  end

  def set_keywords
    if self.keywords.empty?
      begin
        # page = MetaInspector.new(self.url)
        page = NewsScraper.keyword_scrape(self.url)

        if (words = ( page.meta_news_keywords || page.meta_keywords || page.meta_keyword ) )
          keywords = words.split(',')
          keywords.map! { |word| word.strip }
          keywords.each do |keyword|
            self.keywords += [keyword.downcase]
          end
        end

        self.keywords = self.keywords.uniq
        self.save

      rescue
        self.destroy
      end

    end
  end

end
