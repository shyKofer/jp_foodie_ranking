class CreateTabelogRestaurantInfos < ActiveRecord::Migration[6.0]
  def change
    create_table :tabelog_restaurant_infos do |t|
      t.integer :uri_id
      t.string :name
      t.string :genre
      t.string :nearby_station
      t.string :distance_from_station
      t.string :rating
      t.integer :review_cnt
      t.string :lunch_budget
      t.string :dinner_budget

      t.timestamps
    end
  end
end
