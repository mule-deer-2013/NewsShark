require 'spec_helper'

describe Channel do
  it { should validate_presence_of :name }
  it { should belong_to :user }

  describe '#scrape_for_articles' do
    let(:channel) { FactoryGirl.create(:channel) }
    it "creates Article objects with Titles and URLs from Google news" do
      pending
      # end
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
