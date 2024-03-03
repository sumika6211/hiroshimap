class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer :user_id
      t.integer :post_genre_id
      t.integer :spot_id
      t.string :name
      t.text :introduction
      t.string :location
      t.float :latitude
      t.float :longitude
      t.timestamps
    end
  end
end
