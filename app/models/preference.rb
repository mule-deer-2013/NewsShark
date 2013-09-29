class Preference < ActiveRecord::Base
  attr_accessible :channel, :author, :publication, :keywords
  belongs_to :channel

  def set_keywords_from(article)
    article.keywords.each do |keyword|
      self.keywords += [keyword]
    end
    self.save
  end

end
