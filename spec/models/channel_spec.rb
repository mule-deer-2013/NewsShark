require 'spec_helper'

describe Channel do 
  it { should validate_presence_of :name }
  it { should belong_to :user }
  context "#scrape_for_articles" do
    it "returns titles and links of articles from Google news" do
      pending
    end
  end
end



