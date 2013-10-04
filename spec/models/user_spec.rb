require 'spec_helper'

describe User do
  context "Validations" do
  
     it { should have_many(:channels).dependent(:destroy)}

  end

end
