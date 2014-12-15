class OrderItemsController < ApplicationController
  def index
    @order_items = OrderItem.all.sort_by(&:name)
    @due_order_items = @order_items.select { |o| o.due? }.sort_by(&:name)
    @due_soon_order_items = @order_items.select { |o| o.due_soon? }.sort_by(&:name)
  end

  def new
    @item = OrderItem.new
  end

  def create
    @order_item = OrderItem.new(order_item_params)
    if @order_item.save
      if location_params['location_id'].present?
        order_item_location_params = location_params.merge({order_item_id: @order_item.id})
        OrderItemLocation.create(order_item_location_params)
      end
      flash[:notice] = "Order Item Saved"
    end
    redirect_to :root
  end

  def edit
    @item = OrderItem.find(params[:id])
  end

  def update
    @order_item = OrderItem.find(params[:id])
    if @order_item.update(order_item_params)
      if location_params['location_id'].present?
        order_item_location_params = location_params.merge({order_item_id: @order_item.id})
        OrderItemLocation.create(order_item_location_params)
      end
      flash[:notice] = "Order Item Updated"
    end
      redirect_to :root
  end

  def purchase
    @order_item = OrderItem.find(params[:id])
    @order_item.purchase
    redirect_to :root
  end

  def postpone
    @order_item = OrderItem.find(params[:id])
    @order_item.postpone
    redirect_to :root
  end

  def set_due
    @order_item = OrderItem.find(params[:id])
    @order_item.set_due
    redirect_to :root
  end

  private

  def order_item_params
    params.require(:order_item).permit(
      :name, :frequency, :frequency_type, :last_purchase
    )
  end

  def location_params
    params.require(:order_item).require(:locations).permit(
      :location_id
    )
  end
end
