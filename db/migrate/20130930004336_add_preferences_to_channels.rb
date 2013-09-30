class AddPreferencesToChannels < ActiveRecord::Migration
  def change
    add_hstore_index :channels, :preferences
  end
end
