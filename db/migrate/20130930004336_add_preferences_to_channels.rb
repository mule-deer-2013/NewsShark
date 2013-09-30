class AddPreferencesToChannels < ActiveRecord::Migration
  def change
    add_column :channels, :preferences, :hstore
  end
end
