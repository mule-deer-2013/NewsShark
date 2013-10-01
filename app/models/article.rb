class Article < ActiveRecord::Base

  include MetaInspector

  attr_accessible :title, :url, :channel_id, :user_feedback, :keywords
  belongs_to :channel
  validates_presence_of :title, :url
  validates_uniqueness_of :url, scope: :channel_id
  before_create :set_publication

  def set_publication
    publication = self.url.sub(/^https?:\/\/(www\.)?/, '')
    self.publication = publication.sub(/(.com||.org(.eg)?||.net)?\/.*$/, '')
  end


# This needs to be D.R.Y
  def set_keywords
    if self.keywords.empty?
      begin
        page = MetaInspector.new(self.url)

        if page.meta_keywords
          keywords = page.meta_keywords.split(',')
          keywords.map! { |word| word.strip }
          keywords.each do |keyword|
            self.keywords += [keyword.downcase]
          end
        end

        if page.meta_keyword
          keywords = page.meta_keywords.split(',')
          keywords.map! { |word| word.strip }
          keywords.each do |keyword|
            self.keywords += [keyword.downcase]
          end
        end

        if page.meta_news_keywords
          keywords = page.meta_keywords.split(',')
          keywords.map! { |word| word.strip }
          keywords.each do |keyword|
            self.keywords += [keyword.downcase]
          end
        end
        self.save

      rescue
        self.destroy
      end
    end
  end
end
