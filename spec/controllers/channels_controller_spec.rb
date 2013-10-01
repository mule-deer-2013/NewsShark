require 'spec_helper'
include SessionsHelper

describe ChannelsController do
  let!(:user) { FactoryGirl.create :user }

  describe "POST create" do
    let(:valid_params) { { :user_id => user.id , :channel => { :name => "Egypt" } } }
    let(:invalid_params) { { :user_id => user.id , :channel => { :name => "" } } }

    context "with valid params" do
      before { sign_in user }

      it "creates a new channel" do
        expect{
          post :create, valid_params
        }.to change{ Channel.count }.by(1)
      end

    end

    context "with invalid params" do

      it "redirects to user show path" do
        sign_in user
        post :create, invalid_params
        response.should redirect_to user
      end

      it "does not create a new channel" do
        expect{
          post :create, invalid_params
        }.to_not change{ Channel.count }
      end

    end
  end

  describe "GET #show" do
    let!(:channel) { FactoryGirl.create :channel }
    let!(:params) { { :user_id => channel.user.id, :id => channel.id } }

    before { sign_in user }

    it "renders the channel's show page" do
      get :show, params
      response.should render_template 'show'
    end
  end

  describe "DELETE #destroy" do
    let!(:channel) { FactoryGirl.create(:channel, user: user) }
    let!(:params) { { :user_id => user.id, :id => channel.id } }

    before { sign_in user }

    it 'should delete channel' do
      expect{
        delete :destroy, params
      }.to change{ Channel.count }.by(-1)
    end

    it 'should redirect to user show' do
      delete :destroy, params
      expect(page).to redirect_to user_path user
    end
  end
end
