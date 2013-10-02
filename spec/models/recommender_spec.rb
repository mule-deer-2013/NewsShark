require 'support/meta_inspector_fake'
require 'spec_helper'

describe Recommender do
  let(:channel) { FactoryGirl.create(:channel) }

  describe ".enough_rated_articles?" do
    context "with 5 rated articles" do
      it "returns true" do
        articles = channel.articles.limit(5)
        articles.each do |article|
          article.update_user_feedback!(rand(-1..1))
        end
        expect(Recommender.enough_rated_articles?(channel)).to be_true
      end
    end

    context "with 2 rated articles" do
      it "returns false" do
        articles = channel.articles.limit(2)
        articles.each do |article|
          article.update_user_feedback!(rand(-1..1))
        end
        expect(Recommender.enough_rated_articles?(channel)).to be_false
      end
    end
  end

  context ".rank_closeness" do
    it "returns a hash" do
      expect(Recommender.rank_closeness(channel.id)).to be_a Hash
    end

    it "returns a hash of article ids and their (un-updated) closeness points" do
      Recommender.stub :enough_rated_articles? => true
      expect(Recommender.rank_closeness(channel.id).keys).to eq channel.articles.map { |article| article.id }
      expect(Recommender.rank_closeness(channel.id).values).to eq [0]*channel.articles.count
    end
  end

  context "Recommender.best_articles_ranked" do
    it "returns an array of articles ranked by closeness points" do
      Recommender.stub :rank_closeness => { 1 => 2,
                                            2 => -1,
                                            3 => 0,
                                            4 => 5 }
      expect(Recommender.best_articles_ranked(channel.id)).to eq [ Article.find(4),
                                                                   Article.find(1),
                                                                   Article.find(3),
                                                                   Article.find(2) ]
    end
  end
end
