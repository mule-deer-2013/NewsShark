class DropPreferences < ActiveRecord::Migration
  def change
    drop_table :preferences
  end
end
