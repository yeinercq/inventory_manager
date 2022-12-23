# == Schema Information
#
# Table name: exports
#
#  id         :bigint           not null, primary key
#  status     :string
#  file_path  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Export < ApplicationRecord
  attr_accessor :key
  #
  # def initialize(hash)
  #   self.key = hash[:key]
  # end
end
