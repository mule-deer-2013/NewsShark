require 'support/meta_inspector_fake'
require 'spec_helper'

describe Channel do
  context "Validations" do
    it { should validate_presence_of :name }
    it { should belong_to :user }
  end

  context "With associated articles" do
    let(:channel) { FactoryGirl.create(:channel_with_articles) }

    describe '#unrated_articles' do
      context "with no articles rated" do
        it "returns all articles" do
          expect(channel.unrated_articles.count).to eq channel.articles.count
        end
      end
      context "with one rated article" do
        it "returns one less unrated article" do
          channel.articles.first.update_user_feedback!(rand(-1..1))
          expect(channel.unrated_articles.count).to eq channel.articles.count - 1
        end
      end
    end

    describe "#minimum_karma_for_relevancy" do
      let(:scaling_factor) { 10.0 }
      it "returns the number of rated articles that a term must appear in to be relevant" do
        channel.stub :rated_articles => ( [FactoryGirl.create(:article)] * 5 )
        expect(channel.minimum_karma_for_relevancy).to eq (channel.rated_articles.count / scaling_factor)
      end
    end

    describe '#update_preferences_from' do
      it "sets the keywords for a channel based on the keywords for an article" do
        article = channel.articles.first
        article.set_keywords
        article.update_user_feedback!(1)
        expect {
          channel.update_preferences_from(article)
        }.to change {
          channel.preferenced_keywords
        }
      end
    end

  end

  context "Without associated articles" do
    let(:channel) { FactoryGirl.create(:channel) }

    describe '#scrape_for_articles' do
      it "creates Article objects from a scrape" do
        expect{
          channel.scrape_for_articles
        }.to change {
          channel.articles.count
        }.from(0)
      end
    end
  end

end
