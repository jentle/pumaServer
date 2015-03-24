class AddPanelIdToOutputs < ActiveRecord::Migration
  def change
    add_column :outputs, :panel_id, :integer
  end
end
