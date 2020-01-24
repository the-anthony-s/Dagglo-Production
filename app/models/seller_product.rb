class SellerProduct < ApplicationRecord


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
