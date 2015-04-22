class AddMaxToPanels < ActiveRecord::Migration
  def change
    add_column :panels, :max, :float
  end
end
