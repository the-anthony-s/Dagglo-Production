# == Schema Information
#
# Table name: seller_products
#
#  id                      :bigint           not null, primary key
#  unit_price              :money
#  min_order_price         :money
#  sku                     :string(10)
#  harmonized_system_code  :string
#  country_code_of_origin  :string
#  province_code_of_origin :string
#  barcode                 :string
#  packaging               :string
#  packaging_details       :text
#  shelf_life              :string
#  supply_ability          :string
#  weight                  :string
#  status                  :string
#  pause                   :boolean
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  product_id              :bigint
#  seller_id               :bigint
#  deleted_at              :datetime
#

class SellerProduct < ApplicationRecord

  acts_as_paranoid

  include PublicActivity::Model
  tracked owner: Proc.new { |controller, model| controller.current_user ? controller.current_user : nil },
          recipient: Proc.new { |controller, model| controller.user_seller_account ? controller.user_seller_account : nil }



  belongs_to :seller, :foreign_key => 'seller_id'
  belongs_to :product, :foreign_key => 'product_id'


  validates_presence_of :product_id



  # Get assigned product barcode
  def get_barcode
    if barcode.present?
      barcode
    elsif !barcode.present? && product.barcode.present?
      product.barcode
    else
      nil
    end
  end


end
