class Order < ActiveRecord::Base
  belongs_to :user
  has_many :order_items
  before_create :set_order_status
  before_save :update_total
  attr_accessible :status, :total, :user_id


  def set_order_status
    self[:status] = "Registered"
  end

  def update_total
    sum = 0
    items = OrderItem.find_all_by_order_id(self.id)
    items.each do |order_item|
      sum = sum + (MenuItem.find(order_item.menu_item.id).price * order_item.quantity)
    end

    self[:total] = sum 
  end
end
