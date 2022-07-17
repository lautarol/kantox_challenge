# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength
describe Checkout do
  context 'calculating the total price of items' do
    it 'returns the total price for the given test data 1' do
      co = Checkout.new(pricing_rules)
      basket = %w[GR1 SR1 GR1 GR1 CF1]
      basket.each do |item|
        co.scan(item)
      end

      price = co.total

      expect(price).to eq('£22.45')
    end

    it 'returns the total price for the given test data 2' do
      co = Checkout.new(pricing_rules)
      basket = %w[GR1 GR1]
      basket.each do |item|
        co.scan(item)
      end

      price = co.total

      expect(price).to eq('£3.11')
    end

    it 'returns the total price for the given test data 3' do
      co = Checkout.new(pricing_rules)
      basket = %w[SR1 SR1 GR1 SR1]
      basket.each do |item|
        co.scan(item)
      end

      price = co.total

      expect(price).to eq('£16.61')
    end

    it 'returns the total price for the given test data 3' do
      co = Checkout.new(pricing_rules)
      basket = %w[GR1 CF1 SR1 CF1 CF1]
      basket.each do |item|
        co.scan(item)
      end

      price = co.total

      expect(price).to eq('£30.57')
    end
  end
end
