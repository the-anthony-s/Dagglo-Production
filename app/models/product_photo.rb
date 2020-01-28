class ProductPhoto < ApplicationRecord

  include ImageUploader::Attachment(:image)

  validates_presence_of :image

end
