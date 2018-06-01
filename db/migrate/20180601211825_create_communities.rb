class CreateCommunities < ActiveRecord::Migration[5.2]
  def change
    create_table :communities do |t|
      t.string :community
      t.string :price
      t.string :location
      t.string :url
      t.string :img
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
