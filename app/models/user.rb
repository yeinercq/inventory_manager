# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  company_id             :bigint           not null
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :company

  has_many :products, dependent: :destroy
  has_many :movements, through: :products # TODO: association with movments through products
  has_many :sales, dependent: :destroy
  has_one :profile, dependent: :destroy
  has_many :exports, dependent: :destroy
  has_many :transactions, dependent: :destroy
  has_many :coffee_purchases, dependent: :destroy

  scope :has_profile, -> { joins(:profile) }

  def name
    if profile.nil?
      email.split('@').first.capitalize
    else
      profile.name.split(' ').first.capitalize
    end
  end
end
