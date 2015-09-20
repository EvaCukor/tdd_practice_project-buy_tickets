module ApplicationHelper
  def total_price(cart_items)
    total = 0
    cart_items.each do |cart_item|
      total += cart_item.subtotal
    end
    return total
  end
end
