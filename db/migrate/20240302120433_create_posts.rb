class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.string :name
      t.text :introduction
      t.string :location
      t.float :latitude
      t.float :longitude
      t.timestamps
    end
  end
end
