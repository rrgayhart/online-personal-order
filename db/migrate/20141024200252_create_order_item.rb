class CreateOrderItem < ActiveRecord::Migration
  def change
    create_table :order_items do |t|
      t.string :name, null: false
      t.integer :frequency, default: 0
      t.string :frequency_type, default: 'month'
      t.date :last_purchase
    end
  end
end
