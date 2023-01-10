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

  defore_create :generate_report

  def generate_report
    CsvReportGeneratorJob.new.perform(id)
  end
end
