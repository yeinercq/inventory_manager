# == Schema Information
#
# Table name: profiles
#
#  id          :bigint           not null, primary key
#  name        :string
#  title       :string
#  description :text
#  picture     :string
#  user_id     :bigint           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
require 'rails_helper'

RSpec.describe Profile, type: :model do
  let(:user) {create(:user)}
  let(:profile) {build(:profile, user: user)}

  describe 'associations' do
    it { should belong_to(:user) }
  end

  it 'is persisted' do
    expect(profile.save).to eq true
  end
end
