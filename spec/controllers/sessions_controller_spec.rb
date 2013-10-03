require 'support/meta_inspector_fake'
require 'spec_helper'


describe SessionsController  do
  describe 'POST #create' do
    let!(:user) { FactoryGirl.create(:user) }

    let(:valid_params) { { :email => user.email, :password => user.password } }
    let(:invalid_params) { { :email => '', :password => '1234' } }

    context 'sign in with invalid params' do
      before(:each) { post :create, :session =>  invalid_params }
      it "should redirect to user path" do
        controller.should_not_receive(:sign_in)
      end

      it "should raise a flash notice error" do
        flash[:notice].should_not be_nil
      end
    end

    context 'sign in with valid params' do
      it "should login the user" do
        controller.should_receive(:sign_in)#.with(:user)
        post :create, :session => valid_params
      end

      it "should redirect to user path" do
        post :create, :session => valid_params
        page.should redirect_to user_path user
      end

      it "attempts to authenticate user with valid params " do
        User.should_receive(:find_by_email).and_return(user)
        user.should_receive(:authenticate)
        post :create, :session => valid_params
      end

      it "receives the #authenticate method" do
        User.any_instance.should_receive(:authenticate).and_return(true)
        post :create, :session => valid_params
      end

      it "doesnt break when it cant find the user" do
        expect{
          User.should_receive(:find_by_email).and_return(nil)
          post :create, :session => valid_params
        }.to_not raise_error
      end
    end
  end

  describe "#destroy" do
    context 'signed in' do
      it "should sign out user" do
        controller.stub :signed_in? => true
        controller.should_receive(:sign_out)
        delete :destroy
      end

      it "should redirect to root" do
        delete :destroy
        page.should redirect_to new_user_path
      end
    end

    context 'not signed in' do
      it "should not sign out user" do
        controller.stub :signed_in? => false
        controller.should_not_receive(:sign_out)
        delete :destroy
      end
    end
  end
end
