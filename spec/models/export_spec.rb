# == Schema Information
#
# Table name: exports
#
#  id           :bigint           not null, primary key
#  status       :string
#  file_path    :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  key          :string
#  data_filters :hstore
#  user_id      :bigint           not null
#
require 'rails_helper'

RSpec.describe Export, type: :model do
  
end
