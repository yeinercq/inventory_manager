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
class Export < ApplicationRecord
  belongs_to :user

  after_create :generate_report

  scope :ordered,-> { order(id: :desc) }

  VALID_KEYS = [ "ventas_report", "cafe_report" ]
  validates :key, inclusion: { in: VALID_KEYS }

  def generate_report
    CsvReportGeneratorJob.new.perform(id)
  end

  def self.valid_keys
    VALID_KEYS
  end
end
