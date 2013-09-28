class Channel < ActiveRecord::Base

  require Rails.root.join('app/workers/articles_worker')
  
  attr_writer :articles

  after_save :scrape_for_articles

  attr_accessible :name, :user_id
  validates_presence_of :name
  # has_many :articles

  belongs_to :user

  def articles
    @articles || [{}]
  end

  private

  def scrape_for_articles
    ArticleWorker.perform_async(self)
  end

end
