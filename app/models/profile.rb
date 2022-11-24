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
class Profile < ApplicationRecord
  belongs_to :user
  validate :picture_size
  
  mount_uploader :picture, PictureUploader

  private

  def picture_size
    if picture.size > 3.megabytes
      errors.add(:picture, "should be less than 3MB")
    end
  end
end
