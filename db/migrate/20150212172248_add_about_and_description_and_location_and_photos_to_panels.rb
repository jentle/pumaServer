class AddAboutAndDescriptionAndLocationAndPhotosToPanels < ActiveRecord::Migration
  def change
    add_column :panels, :about, :text
    add_column :panels, :description, :text
    add_column :panels, :location, :integer
    add_column :panels, :photos, :string
  end
end
