class Channel < ActiveRecord::Base

  attr_accessible :name, :user_id
  validates_presence_of :name

  belongs_to :user
  has_many :articles

  def scrape_for_articles
    # "returns titles and links of articles from Google news"
    # articles = []
    doc = Nokogiri::HTML(open("https://www.google.com/search?hl=en&gl=us&tbm=nws&authuser=0&q=#{self.name.gsub(' ', '+')}&oq=#{self.name.gsub(' ', '+')}&gs_l=news"))
    
    puts doc
    puts doc.class

    doc.xpath('//h3').children.each do |nokogiri_element|
      if nokogiri_element.attribute('href').to_s.start_with?('/url?q=')
        headline = nokogiri_element.inner_text
        url = nokogiri_element.attribute('href').to_s.sub('/url?q=', '')
        # url_sanitized = url[0...url.rindex(/\//)]       
        self.articles.create(:title => headline, :url => url)
        self.articles.last.set_keywords
      end
    end

    # BUG BUG
    # NYTimes articles may need https prefix
  end

end

