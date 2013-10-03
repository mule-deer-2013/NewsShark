require 'spec_helper'

describe ArticleScraper do
  context ".get_article_attributes" do
    before do
      doc = Object.new
      stats = Object.new
      
      Pismo::Document.stub :new => doc
      Lingua::EN::Readability.stub :new => stats

      doc.stub :author => "john doe"
      doc.stub :keywords => [['these', 10], ['are', 4], ['keywords', 6]]
      doc.stub :datetime => "Thu, 03 Oct 2013"
      doc.stub :description => "This is a description of my article"
      stats.stub :kincaid => 12.278
      doc.stub :body => "This is my fake article"
    end

    it "should return a hash with keys of author, keywords, datetime, description, word_count, and kincaid" do
      expect( ArticleScraper.get_article_attributes("www.fakeurl.com") ).to be_a( Hash )
    end

    it "should return a hash containing :author, :keywords, :datetime, :description, :word_count, and :kincaid" do
      attributes = {
        :author => "john doe",
        :keywords => ["these", "are", "keywords"],
        :datetime => "Thu, 03 Oct 2013",
        :description => "This is a description of my article",
        :word_count => 1,
        :kincaid => 4
      }
      expect( ArticleScraper.get_article_attributes("www.fakeurl.com") ).to eq( attributes )
    end

  end
end
