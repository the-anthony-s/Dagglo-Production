# == Schema Information
#
# Table name: products
#
#  id                    :bigint           not null, primary key
#  name                  :string
#  barcode               :string
#  about                 :text
#  country               :string
#  min_price             :money
#  num_offers            :integer
#  manufacturer_warranty :boolean
#  status                :integer          default("0")
#  image_data            :text
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  category_id           :bigint
#  owner_user_id         :bigint
#  owner_seller_id       :bigint
#  slug                  :string
#  deleted_at            :datetime
#

class Product < ApplicationRecord

  acts_as_paranoid

  # Custom IDs for URLs
  extend FriendlyId
  friendly_id :name, use: :slugged, :use => :history



  # belongs_to :category, :foreign_key => 'category_id'
  belongs_to :category
  belongs_to :owner_user, optional: true, class_name: "User"
  belongs_to :owner_seller, optional: true, class_name: "Seller"

  has_many :seller_products, dependent: :delete_all
  has_many :sellers, :through => :seller_products
  has_many :product_photos, dependent: :destroy

  accepts_nested_attributes_for :product_photos, allow_destroy: true

  include ImageUploader::Attachment(:image)



  # Mandatory fields
  validates_presence_of :name, :barcode, :category



  # Search configurations
  searchkick callbacks: :async, conversions: [:conversions], match: :text_middle, searchable: [:name, :barcode, :category], suggest: [:name, :barcode, :category]
  scope :search_import, -> { includes(:category) }

  def search_data
    {
      name: name,
      barcode: barcode,
      category: category.name,
      # sellers: sellers.map(&:name),
      conversions: map_conversions
      # conversions: searches.group(:query).uniq.count(:user_id)
    }
  end

  # https://github.com/ankane/searchkick#keep-getting-better
  def map_conversions
    results = Searchjoy::Search.where(convertable_id: id)
    results.each_with_object(Hash.new(0)) { |element, result| result[element.query] += 1 }
  end



  # Product statuses
  enum status: {
    pending: 0,
    active: 1,
    paused: 2,
    banned: 3
  }

  def get_status
    status
  end



  # Get product first photo
  def photo(height = nil, width = nil)
    if product_photos.present?
      photo = product_photos.last
      if height != nil && width != nil
        photo.image.derivation_url(:thumbnail, height, width).to_s
      else
        image.url
      end
    else
      ActionController::Base.helpers.asset_path("defaults/" + ["product.png"].compact.join('_'))
    end
  end


  # Country code to Country full name
  # country_select gem saves first two letters of names -> CA, RU, etc
  def country_full_name
    @country_full_name || country_name = ISO3166::Country[country]
    country_name.translations[I18n.locale.to_s] || country_name.name
  end

  def country_name
    country = self.country
    ISO3166::Country[country]
  end

end