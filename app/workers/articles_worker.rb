class ArticleWorker
  include Sidekiq::Worker

  def perform(channel)
    articles = []
    doc = Nokogiri::HTML(open("https://www.google.com/search?hl=en&gl=us&tbm=nws&authuser=0&q=#{channel.name}&oq=#{channel.name}&gs_l=news"))
    doc.xpath('//h3').children.each do |nokogiri_element|
      if nokogiri_element.attribute('href').to_s.start_with?('/url?q=')
        headline = nokogiri_element.inner_text
        url = nokogiri_element.attribute('href').to_s.sub('/url?q=', '')       
        articles << { headline => url }
      end
    end
    channel.articles = articles
    channel.save
  end
end
