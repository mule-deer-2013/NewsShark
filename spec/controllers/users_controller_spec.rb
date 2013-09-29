require 'spec_helper'

describe UsersController do

  describe "GET #show" do
    let(:valid_params) { {:email => "thomas@me.com", :password => "123notit"} }

    context "when not signed in" do
      it "should redirect to signin_path" do
        get :show, :id => 5
        response.should redirect_to signin_path
      end
    end

    context "when signed in" do
      it "should render the user's show template" do
        controller.stub :signed_in? => true
        get :show, :id => 5
        response.should render_template("show")
      end
    end
  end

  describe "GET new" do
    it "renders the new_template" do
      get :new
      expect(response).to render_template('new')
    end
  end

  describe "POST #create" do
    let(:valid_params) { { first_name: 'Ian', last_name: 'Root', email: 'ianroot@gmail.com', password: 'newshark', password_confirmation: 'newshark'} }
    let(:invalid_params) { {first_name: '' , last_name: '', email: ''} }

    context "with valid params" do
      it "creates a new user" do
        expect{
          post :create, :user => valid_params
        }.to change{ User.count }.by(1)
      end
      it "redirects to users show page" do
        post :create, :user => valid_params
        response.should redirect_to user_path(User.last)
      end
    end

    context "with invalid_params" do
      it "does not create user" do
        expect{
          post :create, :user => invalid_params
        }.to_not change{ User.count }
      end
      it "redirects to new user route" do
        post :create, :user => invalid_params
        response.should redirect_to new_user_path
      end
    end
  end

  describe "GET show" do
    let(:user) { FactoryGirl.create :user }

    it "assigns @channel" do
      get :show, :id => user.id
      expect(assigns(:user)).to be_a User
    end

    it "assigns @channel" do
      get :show, :id => user.id
      expect(assigns(:channel)).to be_an_instance_of Channel
    end
  end

end
