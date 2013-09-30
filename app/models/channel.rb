class Channel < ActiveRecord::Base
  serialize :preferences, ActiveRecord::Coders::Hstore

  attr_accessible :name, :user_id, :preferences
 
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

  def set_preferences_from(article)
    set_pref_keywords(article.keywords.join(','))
    # set_pref_author(article.author)
    # set_pref_publication(article.publication)
  end

  # private  

  def set_pref_keywords(keywords_string)

    if self.preferences["keywords"]
      self.preferences["keywords"] << ","
      self.preferences["keywords"] << keywords_string
    else
      self.preferences["keywords"] = keywords_string
    end

    self.save
  end


end
