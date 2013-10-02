require 'spec_helper'

describe User do
  context "Validations" do
    it { should validate_presence_of (:email) }
    it { should validate_presence_of (:first_name) }
    it { should validate_presence_of (:last_name) }
    it { should validate_presence_of (:password) }
    it { should validate_presence_of (:password_confirmation) }
    it { should have_many :channels }
  end

  context "when destroyed" do
    let(:user) { FactoryGirl.create :user }
    let(:channel) { FactoryGirl.create :channel } 
    it "should destroy all of its channels" do
      pending
      expect{ user.destroy }.to change{ Channel.count }
    end
  end
end
