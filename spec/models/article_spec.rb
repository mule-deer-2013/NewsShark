require 'spec_helper'
describe Article do
  it { should belong_to :channel }
  it { should validate_presence_of :title }
  it { should validate_presence_of :url }

  context "#set_keywords" do 
    it "sets keywords" do 
      pending
    end
  end

end
