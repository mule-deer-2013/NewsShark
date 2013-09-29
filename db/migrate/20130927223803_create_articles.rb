class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.belongs_to :channel
      t.string :title
      t.string :url
      t.string :keywords, array: true, default: []

      t.timestamps
    end
  end

end
