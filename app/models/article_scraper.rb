class ArticleScraper
  def self.get_article_attributes(url)
    article_attributes = {}
    reading_level_ranges = { (0..8.82) => 1, (8.82..10.3) => 2, (10.3..11.73) => 3, (11.73..13.15) => 4, (13.15..100) => 5}
    doc = Pismo[url]
    article_attributes[:author] = doc.author
    article_attributes[:keywords] = Hash[doc.keywords].keys
    stats = Lingua::EN::Readability.new(doc.body)
    article_attributes[:word_count] = doc.body.split(' ').count
    article_attributes[:datetime] = doc.datetime
    article_attributes[:description] = doc.description
    reading_level_ranges.each_pair do |range, quintile|
      article_attributes[:kincaid] = quintile if range.include?(stats.kincaid)
    end
    article_attributes
  end
end
