class OrderItemsController < ApplicationController
  def index
    @order_items = OrderItem.all.sort_by &:name rescue []
    @due_order_items = @order_items.select { |o| o.due? }.sort_by &:name rescue []
    @due_soon_order_items = @order_items.select { |o| o.due_soon? }.sort_by &:name rescue []
  end

  def create
    @order_item = OrderItem.new(order_item_params)
    if @order_item.save
      flash[:notice] = "Order Item Saved"
      redirect_to @order_items
    else
      render :new
    end
  end

  def update
    if @order_item.update(order_item_params)
      flash[:notice] = "Order Item Updated"
      redirect_to @order_items
    else
      render :edit
    end
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
end
