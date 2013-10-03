require 'support/meta_inspector_fake'
require 'spec_helper'

describe Article do
  context "Validations and Associations" do
    it { should belong_to :channel }
    it { should validate_presence_of :title }
    it { should validate_presence_of :url }
  end

  describe '#compute_closeness_to' do
    let(:article) { FactoryGirl.create :article }
    let(:channel) { article.channel }

    it "returns the closeness of an article to its channel" do
      channel.stub :minimum_karma_for_relevancy => 2

      article.stub :keywords => ["these", "are"]
      article.stub :publication => "nytimes"

      channel.stub :preferenced_keywords => ({"these" => "3", "are" => "1", "the" => "2", "preferenced keywords" => "0" })
      channel.stub :preferenced_publications => ({"nytimes" => "3", "economist" => "1"})

      expect(article.compute_closeness).to eq 6
    end
  end

end
