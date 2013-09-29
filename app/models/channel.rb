class Channel < ActiveRecord::Base

  attr_accessible :name, :user_id
  validates_presence_of :name

  belongs_to :user
  has_many :articles

  def scrape_for_articles
    # "returns titles and links of articles from Google news"
    doc = Nokogiri::HTML(open("https://www.google.com/search?hl=en&gl=us&tbm=nws&authuser=0&q=#{self.name.gsub(' ', '+')}&oq=#{self.name.gsub(' ', '+')}&gs_l=news"))

    doc.xpath('//a').each do |link|
      if link.to_s.start_with?('<a href="/url?q=')
        headline = link.inner_text
        url_front_sanitized = link['href'].to_s.sub('/url?q=', "")
        url = url_front_sanitized[0...url_front_sanitized.index("&sa")]
        self.articles.create(title: headline, url: url)
        # self.articles.last.set_keywords
      end
    end
    # scrape_sanitize_front = doc.xpath('//a').map do |link|
    #   link.to_s.sub('<a href="/url?q=', "")
    # end

    # select_https = scrape_sanitize_front.select do |potential_url| potential_url.start_with?("http")
    # end

    # sanitized_urls = select_https.map do |bad_url|
    #   bad_url[0...bad_url.index("&amp;")]
    # end

    # sanitized_urls.each do |url|
    #   self.articles.create(:title => headline, :url => url)
    #     self.articles.last.set_keywords
    # end

    # BUG BUG
    # NYTimes articles may need https prefix
  end

end
