ActiveAdmin.register Seller do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :name, :business_number, :about, :country, :founding_date, :status, :private, :image_data, :cover_data, :slug, :onboarding_completed_at, :stripe_id, :card_brand, :card_last4, :card_exp_month, :card_exp_year, :deleted_at
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :business_number, :about, :country, :founding_date, :status, :private, :image_data, :cover_data, :slug, :onboarding_completed_at, :stripe_id, :card_brand, :card_last4, :card_exp_month, :card_exp_year, :deleted_at]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
