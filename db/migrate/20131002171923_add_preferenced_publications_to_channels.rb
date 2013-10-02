class AddPreferencedPublicationsToChannels < ActiveRecord::Migration
  def change
    add_column :channels, :preferenced_publications, :hstore
  end
end
