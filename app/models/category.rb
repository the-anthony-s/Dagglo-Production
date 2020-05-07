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
#  image_data         :text
#  pause              :boolean          default(FALSE)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  views              :integer
#  slug               :string
#

class Category < ApplicationRecord

  # Custom IDs for URLs
  extend FriendlyId
  friendly_id :name, use: :slugged, :use => :history


  # Track Views
  is_impressionable counter_cache: true, column_name: :views, :start_date => Date.today.at_beginning_of_week(:monday), :end_date => Date.today.at_end_of_week(:sunday)


  has_ancestry
  has_many :products
  has_many :fields, class_name: "ProductVariation"
  accepts_nested_attributes_for :fields, allow_destroy: true


  # Scope
  scope :is_active, -> { where(pause: false) }
  scope :popular, -> { order(views: :desc) }



  # Background image
  include ImageUploader::Attachment(:image)

  def background(height = nil, width = nil)
    if image.present?
      if height != nil && width != nil
        image.derivation_url(:thumbnail, height, width).to_s
      else
        image_url
      end
    else
      ActionController::Base.helpers.asset_path("defaults/" + ["image.png"].compact.join('_'))
    end
  end


end
