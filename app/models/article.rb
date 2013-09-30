class Article < ActiveRecord::Base

  include MetaInspector

  attr_accessible :title, :url, :channel_id, :keywords
  belongs_to :channel
  validates_presence_of :title, :url
  validates_uniqueness_of :url, scope: :channel_id

  def update_user_feedback(value)
    self.user_feedback = value unless self.user_feedback == value
  end

# This needs to be D.R.Y
  def set_keywords
    if self.keywords.empty?
      begin
        page = MetaInspector.new(self.url)

        if page.meta_keywords
          keywords = page.meta_keywords.split(',')
          keywords.map! { |word| word.strip }
          keywords.each do |keyword|
            self.keywords += [keyword.downcase]
          end
        end

        if page.meta_keyword
          keywords = page.meta_keywords.split(',')
          keywords.map! { |word| word.strip }
          keywords.each do |keyword|
            self.keywords += [keyword.downcase]
          end
        end

        if page.meta_news_keywords
          keywords = page.meta_keywords.split(',')
          keywords.map! { |word| word.strip }
          keywords.each do |keyword|
            self.keywords += [keyword.downcase]
          end
        end

        self.save

      rescue
        self.destroy
      end

    end
  end

end
