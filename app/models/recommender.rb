class Recommender < ActiveRecord::Base # Does this need to be AR::Base?

  def self.rank_closeness(channel_id)
    channel = Channel.find(channel_id)
    closeness = {}
    scaling_factor = 3
    minimum_feedback = 3
    if channel.rated_articles_count >= minimum_feedback
      channel.articles.where( user_feedback: nil ).each do |article|
        article_closeness = 0
        channel.preferred_keywords.each_pair do |term, amplitude|
          article_closeness += (amplitude.to_i/(channel.rated_articles_count/scaling_factor.to_f)).ceil if article.keywords.include?(term)
        end
        closeness[article.id] = article_closeness
      end
    end
    closeness
  end

end
