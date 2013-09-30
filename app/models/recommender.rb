class Recommender < ActiveRecord::Base

  def self.rank_closeness(channel_id)
    channel = Channel.find(channel_id)
    closeness = {}
    channel.articles.each do |article|
      article_closeness = 0
      channel.keyword_prefs.each_pair do |term, amplitude|
        article_closeness += (amplitude/(channel.numfeedback/3.to_f)).ceil if article.include?(term)
      end 
      closeness[article.id] = article_closeness
    end
    closeness
  end

end
