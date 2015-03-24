class CreateDevices < ActiveRecord::Migration
  def change
    create_table :devices do |t|
      t.string :device_id
      t.string :name
      t.integer :port
      t.string :ip

      t.timestamps null: false
    end
  end
end
