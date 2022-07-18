# frozen_string_literal: true

class PricingRules
  DISCOUNTS_FOR_PRODUCTS = {
    'GR1': :buy_1_get_1_free_price,
    'SR1': :fixed_discount,
    'CF1': :proportional_discount
  }.freeze

  def apply(product, quantity)
    return item_amount_price(product.price, quantity) unless applies_discount?(product.code)

    send(DISCOUNTS_FOR_PRODUCTS[product.code.to_sym], product.price, quantity)
  end

  private

  def applies_discount?(product_code)
    DISCOUNTS_FOR_PRODUCTS.keys.include?(product_code.to_sym)
  end

  def buy_1_get_1_free_price(product_price, quantity)
    return product_price if quantity == 1

    return item_amount_price(product_price, quantity / 2) if quantity.even?

    item_amount_price(product_price, (quantity / 2 + 1))
  end

  def fixed_discount(product_price, quantity, discount_amount = 0.5)
    return item_amount_price(product_price, quantity) unless quantity >= 3

    item_amount_price(product_price - discount_amount, quantity)
  end

  def proportional_discount(product_price, quantity, discount_amount = 2 / 3.0)
    return item_amount_price(product_price, quantity) unless quantity >= 3

    item_amount_price(product_price * discount_amount, quantity)
  end

  def item_amount_price(product_price, quantity)
    product_price * quantity
  end
end
