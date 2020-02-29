ActiveAdmin.register SellerLocation do

  belongs_to :seller

  permit_params do
    permitted = [:name, :street, :city, :zip, :state, :country, :longitude, :latitude, :phone, :pause, :seller_id, :deleted_at]
    # permitted << :other if params[:action] == 'create' && current_user.admin?
    # permitted
  end
  
end
