class CreateTabelogRestaurants < ActiveRecord::Migration[6.0]
  def change
    create_table :tabelog_restaurants do |t|
      t.string :city
      t.string :prefecture_group_id
      t.string :prefecture
      t.string :score
      
      t.timestamps
    end
  end
end
