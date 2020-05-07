# == Schema Information
#
# Table name: products
#
#  id                 :bigint           not null, primary key
#  name               :string
#  description        :text
#  variations         :hstore
#  country_code       :string
#  barcode            :string
#  status             :integer          default("pending")
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  category_id        :bigint
#  owner_user_id      :bigint
#  owner_seller_id    :bigint
#  deleted_at         :datetime
#  views              :integer
#  slug               :string
#  product_barcode_id :bigint
#

class Product < ActiveRecord::Base
  extend Pagy::Search

  # Track Deleted Records -> Mark as deleted :deleted_at
  acts_as_paranoid


  # Custom IDs for URLs
  extend FriendlyId
  friendly_id :name, use: :slugged, :use => :history



  belongs_to :category, optional: true
  belongs_to :owner_user, optional: true, class_name: "User"
  belongs_to :owner_seller, optional: true, class_name: "Seller"

  
  has_one :product_barcode, dependent: :delete

  has_many :seller_products, dependent: :delete_all
  has_many :sellers, :through => :seller_products
  has_many :product_photos, dependent: :delete_all
  has_many :product_likes, dependent: :delete_all
  has_many :pricings, dependent: :delete_all

  accepts_nested_attributes_for :product_photos, allow_destroy: true

  # after_commit :reindex_product


   # Track Views
  is_impressionable counter_cache: true, column_name: :views, :start_date => Date.today.beginning_of_week, :end_date => Date.today.end_of_week

  
  # Scopes
  scope :is_active,         -> { where(status: :pending) }
  scope :is_new,            -> { order(created_at: :desc) }
  scope :popular,           -> { order(views: :asc) }
  scope :search_import,     -> { includes(:category, :sellers, :seller_products, :product_barcode) }
  # scope :search_import,     -> { includes(:category, :sellers, :seller_products, :product_barcode).where(status: :active) }


  # Mandatory fields
  store_accessor :variations
  validate :validate_variations
  validates_presence_of :name


  def validate_variations
    category.fields.each do |f|
      if f.required? && variations[f.name].blank?
        errors.add f.name, "must not be blank"
      end
    end
  end


  after_save :validate_barcode
  def validate_barcode
    if saved_change_to_barcode?
      gtin = Barkick::GTIN.new("#{self.barcode}")
      ProductBarcode.create(
        barcode: self.barcode,
        gtin14: gtin.gtin14,
        ean13: gtin.ean13,
        upc: gtin.upc,
        prefix: gtin.prefix,
        prefix_name: gtin.prefix_name,
        country_code: gtin.country_code,
        price: gtin.price,
        base_gtin14: gtin.base_gtin14,
        product_id: self.id
      )
    end
  end



  # Search configurations
  searchkick callbacks: :async, conversions: [:conversions], match: :text_middle, searchable: [:name, :barcode, :category, :seller], suggest: [:name, :barcode, :category, :seller]

  
  def search_data
    {
      name: name,
      description: description,
      barcode: barcode,
      category: category.name,
      seller: sellers.map(&:name),
      variations: variations,
      conversions: map_conversions,
    }
  end


  # https://github.com/ankane/searchkick#keep-getting-better
  def map_conversions
    results = Searchjoy::Search.where(convertable_id: id)
    results.each_with_object(Hash.new(0)) { |element, result| result[element.query] += 1 }
  end


  def pagy_get_items(collection, pagy)
    collection.offset(pagy.offset).limit(pagy.items)
  end


  def should_index?
    status # only index active records
  end



  # Product Stataus
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
      photo = product_photos.first
      if height != nil && width != nil
        photo.image.derivation_url(:thumbnail, height, width).to_s
      else
        photo.image_url
      end
    else
      ActionController::Base.helpers.asset_path("defaults/" + ["product.png"].compact.join('_'))
    end
  end


  def gallery(height = nil, width = nil)
    if product_photos.present?
      if height != nil && width != nil
        photo.image.derivation_url(:thumbnail, height, width).to_s
      else
        photo.image_url
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
