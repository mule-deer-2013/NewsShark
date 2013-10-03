class AddPreferencesFieldsToChannels < ActiveRecord::Migration
  def change
    add_column :channels, :preferenced_authors, :hstore
    add_column :channels, :preferenced_word_counts, :hstore
    add_column :channels, :preferenced_kincaids, :hstore
  end
end
