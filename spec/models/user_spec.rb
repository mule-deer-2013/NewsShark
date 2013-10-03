require 'spec_helper'

describe User do
  context "Validations and Associations" do
    it { should validate_presence_of (:email) }
    it { should validate_presence_of (:first_name) }
    it { should validate_presence_of (:last_name) }
    it { should validate_presence_of (:password) }
    it { should validate_presence_of (:password_confirmation) }
    it { should have_many(:channels).dependent(:destroy) }
  end

end
