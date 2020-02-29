ActiveAdmin.register SellerProduct do

  belongs_to :seller

  permit_params do
    permitted = [:unit_price, :min_order_price, :sku, :harmonized_system_code, :country_code_of_origin, :province_code_of_origin, :barcode, :packaging, :packaging_details, :shelf_life, :supply_ability, :weight, :status, :pause, :product_id, :seller_id, :deleted_at]
    # permitted << :other if params[:action] == 'create' && current_user.admin?
    # permitted
  end


  controller do
    def scoped_collection
      SellerProduct.includes(:product, :seller)
    end
  end


  index do
    selectable_column
    id_column
    column :product
    column :seller
    column :pause
    actions
  end
  
end
