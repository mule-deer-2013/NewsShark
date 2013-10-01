class Recommender < ActiveRecord::Base # Does this need to be AR::Base?

  def self.rank_closeness(channel_id)
    channel = Channel.find(channel_id)
    closeness = {}
    if channel.numfeedback >= 3
      channel.articles.each do |article|
        article_closeness = 0
        channel.preferred_keywords.each_pair do |term, amplitude|
          article_closeness += (amplitude/(channel.numfeedback/3.to_f)).ceil if article.keywords.include?(term)
        end
        closeness[article.id] = article_closeness
      end
    end
    closeness
  end

end
