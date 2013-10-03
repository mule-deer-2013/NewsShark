require 'spec_helper'

describe Member do

  context "Validations" do
    it { should validate_presence_of (:email) }
    it { should validate_presence_of (:first_name) }
    it { should validate_presence_of (:last_name) }
    it { should have_many(:channels).dependent(:destroy)}

    context "#guest?" do
      it "sets guest? to false" do
        expect{ Member.guest? }.to be_false
      end
    end
  end
end
