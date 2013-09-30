class Channel < ActiveRecord::Base
  serialize :preferenced_keywords, ActiveRecord::Coders::Hstore

  attr_accessible :name, :user_id, :preferenced_keywords

  validates_presence_of :name

  belongs_to :user
  has_many :articles


  def scrape_for_articles
    # "returns titles and links of articles from Google news"
    doc = Nokogiri::HTML(open("https://www.google.com/search?hl=en&tbm=nws&q=#{self.name.gsub(' ', '+')}&gs_l=news"))
    doc.xpath('//a').each do |link|
      if link.to_s.start_with?('<a href="/url?q=')
        headline = link.inner_text
        url_front_sanitized = link['href'].to_s.sub('/url?q=', "")
        url_remove_ampsa = url_front_sanitized.gsub(/&sa.*/,'')
        url = url_remove_ampsa.gsub(/%3.*/,'')
        begin
          self.articles.create(title: headline, url: url)
          article = self.articles.last
          if article.valid?
            ArticleWorker.perform_async(article.id)
          end
        rescue
        end
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