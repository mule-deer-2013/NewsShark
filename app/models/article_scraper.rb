
class ArticleScraper
  def self.get_article_attributes(url)
    article_attributes = {}
    doc = Pismo::Document.new(url)
    stats = Lingua::EN::Readability.new(doc.body)

    reading_level_ranges = { (0..8.82)      => 1,
                             (8.82..10.3)   => 2,
                             (10.3..11.73)  => 3,
                             (11.73..13.15) => 4,
                             (13.15..100)   => 5 }

    word_count_ranges = {   (1..185)        => 1,
                            (185..280)      => 2,
                            (280..405)      => 3,
                            (405..675)      => 4,
                            (675..5000)     => 5}


    article_attributes[:author] = doc.author
    article_attributes[:keywords] = Hash[doc.keywords].keys
    article_attributes[:datetime] = doc.datetime
    article_attributes[:description] = doc.description

    word_count = doc.body.split(' ').count
    word_count_ranges.each_pair do |range, quintile|
      article_attributes[:word_count] = quintile if word_count.in?(range)
    end

    reading_level_ranges.each_pair do |range, quintile|
      article_attributes[:kincaid] = quintile if range.include?(stats.kincaid)
    end

    article_attributes
  end
end
