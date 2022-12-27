# == Schema Information
#
# Table name: exports
#
#  id         :bigint           not null, primary key
#  status     :string
#  file_path  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  key        :string
#
FactoryBot.define do
  factory :export do
    status { :initialized }
    file_path { "report_path" }
    key { 'some_report' }
  end
end
