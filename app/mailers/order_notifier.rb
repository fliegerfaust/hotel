class OrderNotifier < ActionMailer::Base
  default from: 'Hotel Robot'

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_notifier.received.subject
  #
  def received(order)
  	@order = order

    mail to: order.email, subject: 'Booking at the hotel Edelweiss'
  end
end
