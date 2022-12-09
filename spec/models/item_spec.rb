# == Schema Information
#
# Table name: items
#
#  id         :bigint           not null, primary key
#  quantity   :integer          not null
#  unit_price :decimal(10, 2)   not null
#  sale_id    :bigint           not null
#  product_id :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Item, type: :model do
  let!(:product) { create(:product) }
  # let!(:sale) { create(:sale) }
  subject(:item) { create(:item, product: product) }

  describe 'associations' do
    it { should belong_to(:sale) }
    it { should belong_to(:product) }
  end
  #
  # describe 'validations' do
  #   it { should validate_presence_of(:quantity) }
  #   it { should validate_presence_of(:unit_price) }
  #   it { should validate_uniqueness_of(:product_id).scoped_to(:sale_id) }
  #   it { should validate_numericality_of(:quantity) }
  #   it { should validate_numericality_of(:unit_price) }
  # end

  # it 'is persisted' do
  #   expect(item.save).to eq true
  # end
  #
  # context 'after save' do
  #   before(:each) { item.save }
  #
  #   it 'has an product' do
  #     expect(item.product.id).to eq product.id
  #   end
  #
  #   it 'has a total price' do
  #     expect(item.total_price).to eq 3000
  #   end
  # end
end
