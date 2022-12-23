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
FactoryBot.define do
  factory :export do
    status { :initialized }
    file_path { "report_path" }
    initialize_with { Export.new(key: 'some_report') }
  end
end
