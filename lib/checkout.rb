# frozen_string_literal: true

class Checkout
  def initialize(pricing_rules)
    @pricing_rules = pricing_rules
    @basket = {}
  end

  def scan(product)
    if @basket.key?(product)
      @basket[product] += 1
    else
      @basket[product] = 1
    end
  end

  def total
    total = 0
    @basket.each do |product, quantity|
      total += @pricing_rules.apply(product, quantity)
    end
    "£#{total}"
  end
end
