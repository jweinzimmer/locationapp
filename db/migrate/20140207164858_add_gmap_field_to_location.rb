class AddGmapFieldToLocation < ActiveRecord::Migration
  def change
    add_column :locations, :gmaps, :boolean
  end
end
