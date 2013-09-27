class Channel < ActiveRecord::Base

  attr_accessible :name, :user_id
  validates_presence_of :name

  belongs_to :user

  def scrape_for_articles
    # "returns titles and links of articles from Google news"
    articles = []

    doc = Nokogiri::HTML(open("https://www.google.com/search?hl=en&gl=us&tbm=nws&authuser=0&q=#{self.name}&oq=#{self.name}&gs_l=news"))

    doc.xpath('//h3').children.each do |nokogiri_element|
      if nokogiri_element.attribute('href').to_s.start_with?('/url?q=')
        headline = nokogiri_element.inner_text
        url = nokogiri_element.attribute('href').to_s.sub('/url?q=', '')       
        articles << { headline => url }
      end
    end
    return articles
    # BUG BUG
    # NYTimes articles may need https prefix
  end

end
