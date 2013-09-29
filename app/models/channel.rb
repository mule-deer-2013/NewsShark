class Channel < ActiveRecord::Base

  attr_accessible :name, :user_id
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
        url = url_front_sanitized[0...url_front_sanitized.index("&sa")]
        self.articles.create(title: headline, url: url)
        # self.articles.last.set_keywords
      end
    end
    Fireoffbackgroundjobforotherpages
  end

end
