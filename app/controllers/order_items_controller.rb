class OrderItemsController < ApplicationController
  def index
    @order_items = OrderItem.all
  end
end
