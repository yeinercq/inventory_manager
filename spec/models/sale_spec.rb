# == Schema Information
#
# Table name: sales
#
#  id          :bigint           not null, primary key
#  total       :decimal(10, 2)
#  user_id     :bigint           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  code        :string
#  client_id   :bigint           not null
#  status      :string
#  transitions :hstore           is an Array
#
require 'rails_helper'

RSpec.describe Sale, type: :model do
  describe 'associations' do
    it { should belong_to(:client) }
    it { should have_many(:items) }
  end

  context "with params from scratch" do
    let!(:company) { create :company }
    let!(:client) { create :customer }
    let!(:user) { create :user }
    let(:product_1) { create :product, company: company, unit: :bulto }
    let(:product_2) { create :product, company: company, unit: :bulto }
    let(:item_1) { create( :item, product: product_1) }
    let(:item_2) { create( :item, product: product_2) }

    subject(:sale) do
      described_class.new(
        user: user,
        client: client,
        items: [item_1, item_2]
      )
    end

    it { is_expected.to be_valid }

    context "after save" do
      before(:each) { sale.save }
      it { is_expected.to be_persisted }

      it "has a computed code" do
        expect(sale.code).to be_present
      end
    end
  end

  context "with params from factory bot" do
    let!(:items_count) { 5 }
    subject(:sale) { create(:sale_with_items, items_count: items_count) }

    it 'is persisted' do
      expect(sale.save).to eq true
    end

    context 'after save' do
      before(:each) { sale.save }

      it 'has items added' do
        expect(sale.items.count).to eq items_count
      end
    end
  end
end
