module OrdersHelper
  def verify_user
    unless current_user == @order.user
      render_404
    end
  end

  def save_order
    @order = Order.create(user: current_user)
    @cart.all_events.each do |event|
      order_event = Event.find(event.id)
      @order.events << order_event
      OrderEvent.find_by(order: @order, event: order_event).update(quantity: event.quantity)
    end
    @order
  end

  def set_order
    @order = Order.find(params[:id])
  end

  def send_order_confirmation(order)
    if current_user && current_user.email
      UserNotifierMailer.send_confirmation_email(current_user, order).deliver
    end
  end
end
