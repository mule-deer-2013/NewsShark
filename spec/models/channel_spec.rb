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
end
