class CreateSpots < ActiveRecord::Migration[6.1]
  def change
    create_table :spots do |t|
      t.integer :area_id
      t.string :name
      t.string :location
      t.float :latitude
      t.float :longitude
      t.timestamps
    end
  end
end
