# == Schema Information
#
# Table name: sale_prices
#
#  id          :bigint           not null, primary key
#  price       :decimal(10, 2)   not null
#  product_id  :bigint           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  transitions :hstore           is an Array
#
require 'rails_helper'

RSpec.describe SalePrice, type: :model do
  subject(:sale_price) { build(:sale_price) }

  describe 'associations' do
    it { should belong_to(:product) }
  end

  describe 'validations' do
    it { should validate_presence_of(:price) }
  end

  it 'is persisted' do
    expect(sale_price.save).to eq true
  end

  context 'after save' do
    before(:each) { sale_price.save }

    it 'has a transition record' do
      expect(sale_price.transitions.count).to eq 1
    end
  end
end
