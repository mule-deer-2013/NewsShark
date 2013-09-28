require 'spec_helper'


describe SessionsController  do
  describe 'POST #create' do
    let!(:user) { User.create(:email      => 'thomas@me.com',
                              :first_name => 'thomas',
                              :last_name  => 'landon',
                              :password   => '123notit',
                              :password_confirmation => '123notit')} 

    let(:valid_params) { { :email => 'thomas@me.com',:password => '123notit' } }
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

      it "valid params attempts to authenticate user" do
        User.should_receive(:find_by_email).and_return(user)
        user.should_receive(:authenticate)
        post :create, :session => valid_params
      end

      it "when the user authenticates it redirects to somethin" do
        User.any_instance.should_receive(:authenticate).and_return(true)
        post :create, :session => valid_params
      end

      it "doesnt break when it cant find the user" do
        # make line:
        # if user $$ user.authe......
        # instead of:
        # if user.authen.....

        # User.find_by... should return nil
      end
    end
  end
end