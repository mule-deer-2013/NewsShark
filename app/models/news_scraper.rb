class NewsScraper

  include MetaInspector

  def self.scrape(search_term)
    articles = {}
    doc = Nokogiri::HTML(open("https://www.google.com/search?hl=en&tbm=nws&q=#{search_term.gsub(' ', '+')}&gs_l=news"))

    doc.xpath('//a').each do |link|
      if is_worth_saving?(link)
        begin
          title = link.inner_text
          url_front_sanitized = link['href'].to_s.sub('/url?q=', "")
          url_remove_ampsa = url_front_sanitized.gsub(/&sa.*/,'')
          url = url_remove_ampsa.gsub(/%3.*/,'')
          articles[title] = url
        rescue
        end
      end
    end

    articles
  end

  def self.keyword_scrape(url)
    MetaInspector.new(url)
  end

  private
  def self.is_worth_saving?(link)
    link.to_s.start_with?('<a href="/url?q=')
  end

end



