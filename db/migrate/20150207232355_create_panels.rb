class CreatePanels < ActiveRecord::Migration
  def change
    create_table :panels do |t|

      t.timestamps null: false
    end
  end
end
