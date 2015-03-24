class AddDeviceIdToPanels < ActiveRecord::Migration
  def change
    add_column :panels, :device_id, :integer
  end
end
