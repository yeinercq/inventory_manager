# == Schema Information
#
# Table name: locations
#
#  id            :bigint           not null, primary key
#  name          :string
#  location_type :integer
#  company_id    :bigint           not null
#  user_id       :bigint           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
require 'rails_helper'

RSpec.describe Location, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
