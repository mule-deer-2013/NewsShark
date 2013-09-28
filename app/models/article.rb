class Article < ActiveRecord::Base
  
  include MetaInspector

  attr_accessible :title, :url, :channel_id
  belongs_to :channel
  validates_presence_of :title, :url

  # after_save :set_keywords

  def set_keywords
    page = MetaInspector.new(self.url)
    keywords = page.meta_keywords.split(', ')
    keywords.each do |keyword|
      self.keywords += [keyword.downcase]
    end

    self.save
  end

end
