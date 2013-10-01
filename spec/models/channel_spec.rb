require 'support/meta_inspector_fake'
require 'spec_helper'

describe Channel do
  it { should validate_presence_of :name }
  it { should belong_to :user }

  describe '#scrape_for_articles' do
    let(:channel) { FactoryGirl.create(:channel) }
    it "creates Article objects from a scrape" do
      doc = Nokogiri::HTML(open('./spec/fixtures/pants_google_search.html'))
      NewsScraper.stub(:scrape).and_return(doc)
      channel.stub(:is_worth_saving?).and_return(true, false)

      expect{
        channel.scrape_for_articles
        channel.save
      }.to change{
        channel.reload.articles.count
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
