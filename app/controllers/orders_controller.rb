class OrdersController < ApplicationController

  def show
    @order = Order.find(params[:id])
  end

  def create
    charge = perform_stripe_charge
    order  = create_order(charge)

    if order.valid?
      redirect_to order, notice: 'Your Order has been placed.'
      empty_cart!
    else
      redirect_to cart_path, flash: { error: order.errors.full_messages.first }
    end

  rescue Stripe::CardError => e
    redirect_to cart_path, flash: { error: e.message }
  end

  private

  def empty_cart!
    # empty hash means no products in cart :)
    update_cart({})
  end

  def ordered_email
    @ordered_email ||= Order.where(id: params[:id]).first().email
  end
  helper_method :ordered_email

  def order_line_items
    @order_line_items ||= LineItem.where(order_id: params[:id])
  end
  helper_method :order_line_items

  def ordered_items
    order_line_items.map {|item|  Product.where(id: item.product_id).map {|product| { product:product, quantity:item.quantity, total_price_cents:item.total_price_cents } }}
  end
  helper_method :ordered_items

  def ordered_subtotal_cents
    ordered_items.first.map {|entry| entry[:product].price_cents * entry[:quantity]}.sum
  end
  helper_method :ordered_subtotal_cents

  def perform_stripe_charge
    Stripe::Charge.create(
      source:      params[:stripeToken],
      amount:      cart_subtotal_cents,
      description: "Khurram Virani's Jungle Order",
      currency:    'cad'
    )
  end

  def create_order(stripe_charge)
    order = Order.new(
      email: params[:stripeEmail],
      total_cents: cart_subtotal_cents,
      stripe_charge_id: stripe_charge.id, # returned by stripe
    )

    enhanced_cart.each do |entry|
      product = entry[:product]
      quantity = entry[:quantity]
      order.line_items.new(
        product: product,
        quantity: quantity,
        item_price: product.price,
        total_price: product.price * quantity
      )
    end
    order.save!
    order
  end

end
