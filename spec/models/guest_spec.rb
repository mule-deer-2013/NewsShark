require 'spec_helper'

describe Guest do

  context "Validations" do
    it { should have_many(:channels).dependent(:destroy)}
  end
 
  context "#guest?" do
    it "sets guest? to true" do
      expect{ Guest.guest? }.to be_true
    end
  end

  context "#move_to" do
    pending
  end

end
