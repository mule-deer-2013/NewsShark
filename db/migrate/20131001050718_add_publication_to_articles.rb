class AddPublicationToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :publication, :string
  end
end
