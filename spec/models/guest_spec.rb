require 'spec_helper'

describe Guest do
 
  context "#guest?" do
    it "sets guest? to true" do
      expect{ Guest.guest? }.to be_true
    end
  end

  context "#move_to" do
    pending
  end

end
