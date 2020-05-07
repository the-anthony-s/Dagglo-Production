# == Schema Information
#
# Table name: product_photos
#
#  id         :bigint           not null, primary key
#  product_id :bigint
#  image_data :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ProductPhoto < ApplicationRecord

  include ImageUploader::Attachment(:image)

  validates_presence_of :image

end
