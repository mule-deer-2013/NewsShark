class CreatePreferences < ActiveRecord::Migration
  def change
    create_table :preferences do |t|
      t.belongs_to :channel
      t.string :author
      t.string :publication
      t.string :keywords, array: true, default: []
    end
  end
end
