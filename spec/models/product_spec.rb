# == Schema Information
#
# Table name: products
#
#  id               :bigint           not null, primary key
#  name             :string           not null
#  brand            :string           not null
#  description      :text
#  unit             :integer          not null
#  size             :string           not null
#  price            :decimal(10, 2)   not null
#  user_id          :bigint           not null
#  provider_id      :bigint           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  initial_quantity :integer
#  company_id       :bigint           not null
#
require 'rails_helper'

RSpec.describe Product, type: :model do
  let(:initial_quantity) { 120 }
  subject(:product) { build(:product, initial_quantity: initial_quantity)}

  describe 'associations' do
    it { should belong_to(:company) }
    it { should belong_to(:provider) }
    it { should belong_to(:user) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:brand) }
    it { should validate_presence_of(:unit) }
    it { should validate_presence_of(:price) }
    it { should validate_presence_of(:initial_quantity) }
    it { should validate_uniqueness_of(:name).scoped_to(:company_id).case_insensitive }
    it { should define_enum_for(:unit) }
  end

  it 'is persisted' do
    expect(product.save).to eq true
  end

  context 'after save' do
    before(:each) { product.save }

    it 'has a stock created' do
      expect(product.stocks.count).to eq 1
    end

    it 'has a current_stock' do
      expect(product.current_stock).to eq initial_quantity
    end
  end
end
