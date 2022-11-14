# == Schema Information
#
# Table name: providers
#
#  id           :bigint           not null, primary key
#  name         :string           not null
#  email        :string           not null
#  phone_number :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  company_id   :bigint           not null
#
require 'rails_helper'

RSpec.describe Provider, type: :model do
  let(:email) { "TEST@mail.com" }
  subject(:provider) { build(:provider, email: email) }
  # subject(:provider) { build(:provider) }

  describe 'associations' do
    it { should belong_to(:company) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:phone_number) }
    it { should validate_uniqueness_of(:name).scoped_to(:company_id).case_insensitive }
    it { should validate_uniqueness_of(:email).scoped_to(:company_id).case_insensitive }
  end

  it 'is persisted' do
    expect(provider.save).to eq true
  end

  context 'after save' do
    before(:each) { provider.save }

    it 'has email downcased' do
      expect(provider.email).to eq email.downcase
    end
  end
end
