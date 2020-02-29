ActiveAdmin.register SellerAccount do

  belongs_to :seller

  permit_params do
    permitted = [:role, :user_id, :seller_id, :seller_location_id, :deleted_at, :email]
    # permitted << :other if params[:action] == 'create' && current_user.admin?
    # permitted
  end
  
end
