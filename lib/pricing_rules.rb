# frozen_string_literal: true

class PricingRules
  VALID_PRODUCTS = %w[GR1 SR1 CF1].freeze

  def apply(product, quantity)
    return item_amount_price(product.price, quantity) unless VALID_PRODUCTS.include?(product.code)

    case product.code
    when 'GR1'
      buy_1_get_1_free_price(product.price, quantity)
    when 'SR1'
      if quantity >= 3
        fixed_discount(product.price, quantity)
      else
        item_amount_price(product.price, quantity)
      end
    when 'CF1'
      if quantity >= 3
        proportional_discount(product.price, quantity, 2 / 3.0)
      else
        item_amount_price(product.price, quantity)
      end
    end
  end

  private

  def buy_1_get_1_free_price(product_price, quantity)
    return product_price if quantity == 1

    return item_amount_price(product_price, quantity / 2) if quantity.even?

    item_amount_price(product_price, (quantity / 2 + 1))
  end

  def fixed_discount(product_price, quantity, discount_amount = 0.5)
    item_amount_price(product_price - discount_amount, quantity)
  end

  def proportional_discount(product_price, quantity, discount_amount)
    item_amount_price(product_price * discount_amount, quantity)
  end

  def item_amount_price(product_price, quantity)
    product_price * quantity
  end
end
