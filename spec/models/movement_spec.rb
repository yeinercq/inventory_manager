# == Schema Information
#
# Table name: movements
#
#  id           :bigint           not null, primary key
#  mov_type     :integer          not null
#  mov_sub_type :integer          not null
#  quantity     :integer          not null
#  unit_price   :decimal(10, 2)   not null
#  total        :decimal(10, 2)
#  product_id   :bigint           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  item_id      :bigint
#
require 'rails_helper'

RSpec.describe Movement, type: :model do
  subject(:movement) { build(:movement, quantity: 15)}

  describe 'associations' do
    it { should belong_to(:product) }
  end

  describe 'validations' do
    it { should validate_presence_of(:mov_type) }
    it { should validate_presence_of(:mov_sub_type) }
    it { should validate_presence_of(:quantity) }
    it { should validate_presence_of(:unit_price) }
    it { should define_enum_for(:mov_type) }
    it { should define_enum_for(:mov_sub_type) }
  end

  it 'is persisted' do
    expect(movement.save).to eq true
  end

  context 'after save creates a input stock' do
    before(:each) { movement.save }

    it 'has a created a stock' do
      expect(movement.product.current_stock).to eq 25
    end

  end

  context 'after save does not create a input stock with mov_type = "output"' do
    subject { movement.tap { |m| m.mov_type = "output"} } # changes the mov_type to "output"

    it { is_expected.to_not be_valid }
  end
end
