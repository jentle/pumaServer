class AddLongitudeAndLatitudeToPanels < ActiveRecord::Migration
  def change
    add_column :panels, :longitude, :string
    add_column :panels, :latitude, :string
  end
end
