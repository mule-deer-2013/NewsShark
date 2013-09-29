class AddUserFeedbackToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :user_feedback, :integer
  end
end
