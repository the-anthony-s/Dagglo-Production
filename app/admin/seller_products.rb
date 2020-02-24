ActiveAdmin.register SellerProduct do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :unit_price, :min_order_price, :sku, :harmonized_system_code, :country_code_of_origin, :province_code_of_origin, :barcode, :packaging, :packaging_details, :shelf_life, :supply_ability, :weight, :status, :pause, :product_id, :seller_id, :deleted_at
  #
  # or
  #
  # permit_params do
  #   permitted = [:unit_price, :min_order_price, :sku, :harmonized_system_code, :country_code_of_origin, :province_code_of_origin, :barcode, :packaging, :packaging_details, :shelf_life, :supply_ability, :weight, :status, :pause, :product_id, :seller_id, :deleted_at]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
