require 'support/meta_inspector_fake'
require 'spec_helper'

describe ArticleWorker do
  describe '.perform' do
    let(:article) { FactoryGirl.build(:article) }
    it "should start background JERBS!" do
      ArticleWorker.perform_async(article.id)
      expect(ArticleWorker).to have(15).enqueued.jobs
    end
  end
end