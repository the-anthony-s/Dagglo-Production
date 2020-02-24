# == Schema Information
#
# Table name: announcements
#
#  id         :bigint           not null, primary key
#  name       :string
#  content    :text
#  image_data :text
#  audience   :integer
#  hide       :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Announcement < ApplicationRecord

  # Mandatory fields
  validates_presence_of :name, :content, :audience


  # Scopes
  scope :users, -> { where(hide: :false, audience: 0) }
  scope :sellers, -> { where(hide: :false, audience: 1) }
  scope :buyers, -> { where(hide: :false, audience: 2) }


  # Audience
  enum audience: {
    users: 0,
    sellers: 1,
    buyers: 2
  }

  def get_audience
    audience
  end


  # Image data
  include ImageUploader::Attachment(:image)

end
