require 'support/meta_inspector_fake'
require 'spec_helper'

describe Channel do
  it { should validate_presence_of :name }
  it { should belong_to :user }

  describe '#scrape_for_articles' do
    let(:channel) { FactoryGirl.create(:channel) }

    it "creates Article objects from a scrape" do
      expect{
        channel.scrape_for_articles
      }.to change {
        channel.articles.count
      }
    end
  end

  describe '#update_preferences_from(article)' do
    let(:channel) { FactoryGirl.create(:channel) }
    let(:article) { FactoryGirl.create(:article) }

    it "sets the keywords for a channel based on the keywords for an article" do
      article.set_keywords
      article.update_user_feedback(1)
      expect {
        channel.update_preferences_from(article)
      }.to change {
        channel.preferenced_keywords
      }
    end

  end

end
