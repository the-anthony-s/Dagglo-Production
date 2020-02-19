# == Schema Information
#
# Table name: categories
#
#  id                 :bigint           not null, primary key
#  name               :string
#  ancestry           :string
#  type_of_products   :text
#  conditions_allowed :text
#  approval_required  :text
#  cover_date         :text
#  pause              :boolean          default(FALSE)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  slug               :string
#

class Category < ApplicationRecord


  # Custom IDs for URLs
  extend FriendlyId
  friendly_id :name, use: :slugged, :use => :history


  has_ancestry
  has_many :products


  # Scope
  scope :is_active, -> { where(pause: false) }



  # Background image
  include ImageUploader::Attachment(:cover)

  def background(height = nil, width = nil)
    if cover.present?
      if height != nil && width != nil
        cover.derivation_url(:thumbnail, height, width).to_s
      else
        image.url
      end
    else
      ActionController::Base.helpers.asset_path("defaults/" + ["image.png"].compact.join('_'))
    end
  end


end
