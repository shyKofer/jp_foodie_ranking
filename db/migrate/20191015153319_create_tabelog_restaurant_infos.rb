class CreateTabelogRestaurantInfos < ActiveRecord::Migration[6.0]
  def change
    create_table :tabelog_restaurant_infos do |t|
      t.string :prefecture
      t.string :district
      t.string :restaurant_id
      t.string :rating
      t.integer :reviews

      t.timestamps
    end
  end
end
