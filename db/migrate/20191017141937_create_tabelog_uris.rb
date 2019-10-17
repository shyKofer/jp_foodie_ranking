class CreateTabelogUris < ActiveRecord::Migration[6.0]
  def change
    create_table :tabelog_uris do |t|
      t.string :prefecture
      t.string :area_group_uri
      t.string :area_group_name
      t.string :area_uri
      t.string :area_name

      t.timestamps
    end
  end
end
