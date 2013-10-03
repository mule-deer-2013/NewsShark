require 'support/meta_inspector_fake'
require 'spec_helper'
include SessionsHelper

describe ArticlesController do
  let(:article) { FactoryGirl.create :article }
  let(:channel) { article.channel }
  let(:user) { channel.user }
  let(:params) { { user_id: user.id, channel_id: channel.id, id: article.id, user_feedback: 1 } }

  context "PUT update" do
    before { sign_in user }

    it "finds the article by params" do
      Article.should_receive(:find).with(article.id.to_s).and_return(article)
      put :update, params
    end

    context "with found article" do
      before { Article.stub(:find => article) }

      it "updates user_feedback for article" do
        expect {
          put :update, params
        }.to change {
          article.user_feedback
        }
      end

      it "updates preferences of channel" do
        channel.should_receive(:update_preferences_from).with(article)
        put :update, params
      end

      it "redirects to channel show path" do
        put :update, params
        response.should redirect_to user_channel_path(user, channel)
      end
    end
  end

end
