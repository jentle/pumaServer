class CreateOutputs < ActiveRecord::Migration
  def change
    create_table :outputs do |t|
      t.integer :watt
      t.integer :voltage

      t.timestamps null: false
    end
  end
end
