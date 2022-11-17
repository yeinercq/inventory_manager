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
class Provider < ApplicationRecord
  belongs_to :company
  has_many :products, dependent: :destroy

  validates :name, :email, presence: true
  validates :name, :email, uniqueness: {scope: :company_id,  message: "has already been taken", case_sensitive: false}
  validates :phone_number, presence: true, numericality: { only_integer: true, greater_than: 0 }

  scope :ordered, -> { order(id: :desc) }

  broadcasts_to ->(provider) { [provider.company, "providers"] }, inserts_by: :prepend

  before_save :normalize_email

  def normalize_email
    self.email = email.downcase if email
  end
end
