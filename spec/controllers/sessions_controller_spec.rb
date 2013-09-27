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
        flash[:error].should_not be_nil
      end
    end

    context 'sign in with valid params' do
      before(:each) { post :create, :session => valid_params }  
       it "should login the user" do
          # stub? should_receive
          expect(session[:user_id]).to eq user.id
       end

       it "should redirect to user path" do
         page.should redirect_to user_path user                
       end
     end
  end
end