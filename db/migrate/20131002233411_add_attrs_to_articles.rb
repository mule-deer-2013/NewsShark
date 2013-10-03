class AddAttrsToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :author, :string
    add_column :articles, :word_count, :integer
    add_column :articles, :kincaid, :integer
    add_column :articles, :datetime, :date
    add_column :articles, :description, :text
  end
end
