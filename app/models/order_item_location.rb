class OrderItemLocation < ActiveRecord::Base
  belongs_to :order_item
  belongs_to :location
end
