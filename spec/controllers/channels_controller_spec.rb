require 'support/meta_inspector_fake'
require 'spec_helper'
include SessionsHelper

describe ChannelsController do
  let!(:user) { FactoryGirl.create :member }

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
        expect {
          post :create, invalid_params
        }.to_not change{ Channel.count }
      end

    end
  end

  describe "GET #show" do
    let!(:channel) { FactoryGirl.create :channel_with_articles }
    let!(:params) { { :user_id => channel.user.id, :id => channel.id } }
    let(:user) { channel.user }
    before { sign_in user }
    before { get :show, params }

    it "renders the channel's show page" do
      response.should render_template 'show'
    end

   it "assigns @articles to be an array of articles" do
      channel.articles
      articles = assigns(:articles)
      expect(articles[0]).to be_an Article
      expect(articles.length).to eq channel.articles.length
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
