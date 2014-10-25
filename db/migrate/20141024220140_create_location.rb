class CreateLocation < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :name, null: false
    end

   create_table :order_item_locations do |t|
      t.integer :order_item_id
      t.integer :location_id
    end
  end
end
