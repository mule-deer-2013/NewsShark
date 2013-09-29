class Channel < ActiveRecord::Base

  attr_accessible :name, :user_id
  validates_presence_of :name

  belongs_to :user
  has_many :articles

  has_one :preference

  def scrape_for_articles
    # "returns titles and links of articles from Google news"
    doc = Nokogiri::HTML(open("https://www.google.com/search?hl=en&gl=us&tbm=nws&authuser=0&q=#{self.name.gsub(' ', '+')}&oq=#{self.name.gsub(' ', '+')}&gs_l=news"))

    doc.xpath('//a').each do |link|
      if link.to_s.start_with?('<a href="/url?q=')
        headline = link.inner_text
        url_front_sanitized = link['href'].to_s.sub('/url?q=', "")
        url_remove_ampsa = url_front_sanitized.gsub(/&sa.*/,'')
        url = url_remove_ampsa.gsub(/%3.*/,'')
        begin
          self.articles.create(title: headline, url: url)
        rescue
        end
        article = self.articles.last
        ArticleWorker.perform_async(article.id)
      end
    end
  end

end
