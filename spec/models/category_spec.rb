# == Schema Information
#
# Table name: categories
#
#  id          :bigint           not null, primary key
#  name        :string
#  description :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  company_id  :bigint           not null
#
require 'rails_helper'

RSpec.describe Category, type: :model do
  subject(:category) {build(:category)}

  describe 'associations' do
    it { should belong_to(:company) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_uniqueness_of(:name).scoped_to(:company_id).case_insensitive }
  end

  it 'is persisted' do
    expect(category.save).to eq true
  end
end
