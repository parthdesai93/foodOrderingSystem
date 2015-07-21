class OrdersController < ApplicationController
  def index
    if restaurant_owner_signed_in?
      @order_items = OrderItem.find_all_by_menu_item_id(MenuItem.find_all_by_restaurant_id(Restaurant.find_all_by_restaurant_owner_id(current_restaurant_owner.id)))
      @orders = []
      @order_items.each do |order_item|
        order = Order.find(order_item.order_id)
        unless @orders.include?(order)
        @orders << order
          end
      end
      @orders
      end
  end

  def show
    @order = Order.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])
    @order.status="Ready"
    @order.save
  end

  def destroy
  end
end
