class AddPreferencedKeywordsToChannels < ActiveRecord::Migration
  def change
    remove_column :channels, :preferences
    add_column :channels, :preferenced_keywords, :hstore
  end
end
