require 'support/meta_inspector_fake'
require 'spec_helper'

describe Article do
  it { should belong_to :channel }
  it { should validate_presence_of :title }
  it { should validate_presence_of :url }

  context "#set_keywords" do
    let(:article) { FactoryGirl.create :article }

    it "sets keywords" do
      expect{
        article.set_keywords
      }.to change { article.keywords }
    end
  end

  context "#update_user_feedback" do
    let(:article) { FactoryGirl.create :article }
    it "updates user feedback with argument" do
      expect {
        article.update_user_feedback!(1)
      }.to change {
        article.user_feedback
      }.from(nil).to(1)
    end
  end


  describe '#compute_closeness_to' do
    let(:article) { FactoryGirl.create :article }
    let(:channel) { article.channel }

    it "returns the closeness of an article to its channel" do
      channel.stub :preferenced_keywords => ({"these" => "3", "are" => "1", "the" => "2", "preferenced keywords" => "0" })
      article.stub :keywords => ["these", "are"]
      channel.stub :minimum_karma_for_relevancy => 2

      expect(article.compute_closeness).to eq 3

    end
  end

end
