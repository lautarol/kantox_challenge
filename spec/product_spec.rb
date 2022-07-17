# frozen_string_literal: true
require_relative '../lib/product'
describe Product do
  context 'when a new product is created' do
    context 'with the correct attributes' do
      let(:product) { Product.new('GR1', 'Green tea', 3.11) }

      it 'creates a Product instance' do
        expect(product).to be_kind_of(Product)
      end

      it 'responses to #code' do
        expect(product.code).to eq('GR1')
      end

      it 'responses to #name' do
        expect(product.name).to eq('Green tea')
      end

      it 'response to #price' do
        expect(product.price).to eq(3.11)
      end
    end
    context 'with the incorrect attributes' do
      it 'raises an error' do
        expect { Product.new }.to raise_error(ArgumentError)
      end
    end
  end
end
