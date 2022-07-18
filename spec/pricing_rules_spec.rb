# frozen_string_literal: true

require_relative '../lib/pricing_rules'
require_relative '../lib/product'

describe PricingRules do
  context 'when a new pricing rule is created' do
    let(:pricing_rules) { PricingRules.new }
    it 'should create a PricingRule instance' do
      expect(pricing_rules).to be_kind_of(PricingRules)
    end

    context '#apply should return the correct price' do
      it 'should return the correct price for a random item' do
        random_product = Product.new('RAN', 'Green tea', 5.00)

        expect(pricing_rules.apply(random_product, 3)).to eq(15.00)
      end

      context 'for buy 1 get 1 free items' do
        let(:green_tea) { Product.new('GR1', 'Green tea', 5) }
        it 'should charge 1 unit when buying 1' do
          expect(pricing_rules.apply(green_tea, 1)).to eq(5.00)
        end

        it 'should charge only 1 unit when buying 2' do
          expect(pricing_rules.apply(green_tea, 2)).to eq(5.00)
        end

        it 'should charge 2 units when buying 3' do
          expect(pricing_rules.apply(green_tea, 3)).to eq(10.00)
        end
      end

      context 'for fixed discount items' do
        let(:strawberries) { Product.new('SR1', 'Strawberries', 5.00) }

        it 'should charge the full price when buying 1' do
          expect(pricing_rules.apply(strawberries, 1)).to eq(5.00)
        end

        it 'should charge the full price when buying 2' do
          expect(pricing_rules.apply(strawberries, 2)).to eq(10.00)
        end

        it 'should charge the reduced price when buying 3' do
          expect(pricing_rules.apply(strawberries, 3)).to eq(13.50)
        end
      end

      context 'for percentage discount items' do
        let(:coffe) { Product.new('CF1', 'Coffe', 6.00) }

        it 'should charge the full price when buying 1' do
          expect(pricing_rules.apply(coffe, 1)).to eq(6.00)
        end

        it 'should charge the full price when buying 2' do
          expect(pricing_rules.apply(coffe, 2)).to eq(12.00)
        end

        it 'should charge the reduced price when buying 3' do
          expect(pricing_rules.apply(coffe, 3)).to eq(12.00)
        end
      end
    end
  end
end
