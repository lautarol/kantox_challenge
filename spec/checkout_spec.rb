# frozen_string_literal: true

require_relative '../lib/checkout'
require_relative '../lib/pricing_rules'
require_relative '../lib/product'

describe Checkout do
  context 'calculating the total price of items' do
    let(:pricing_rules) { PricingRules.new }
    let(:co) { Checkout.new(pricing_rules) }
    let(:gr1) { Product.new('GR1', 'Green tea', 3.11) }
    let(:sr1) { Product.new('SR1', 'Strawberries', 5.00) }
    let(:cf1) { Product.new('CF1', 'Coffee', 11.23) }

    it 'returns the total price for the given test data 1' do
      basket = [gr1, sr1, gr1, gr1, cf1]
      basket.each do |item|
        co.scan(item)
      end

      price = co.total

      expect(price).to eq('£22.45')
    end

    it 'returns the total price for the given test data 2' do
      basket = [gr1, gr1]
      basket.each do |item|
        co.scan(item)
      end

      price = co.total

      expect(price).to eq('£3.11')
    end

    it 'returns the total price for the given test data 3' do
      basket = [sr1, sr1, gr1, sr1]
      basket.each do |item|
        co.scan(item)
      end

      price = co.total

      expect(price).to eq('£16.61')
    end

    it 'returns the total price for the given test data 4' do
      basket = [gr1, cf1, sr1, cf1, cf1]
      basket.each do |item|
        co.scan(item)
      end

      price = co.total

      expect(price).to eq('£30.57')
    end
  end
end
