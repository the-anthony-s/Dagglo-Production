ActiveAdmin.register User do
  menu priority: 2



  permit_params do
    permitted = [:email, :password, :first_name, :last_name, :phone_number, :time_zone, :image_data, :private, :status, :unconfirmed_email]
  end
  


  filter :first_name
  filter :last_name
  filter :email
  filter :created_at
  filter :confirmed_at

  scope :all, :default => true



  # Users List -> Index view
  index do
    selectable_column
    id_column
    column :full_name
    column :email
    column :confirmed_at
    actions
  end



  # Show view
  show title: :full_name do
    panel "Order History" do
    end

    # panel "Seller Owner" do
    #   table_for(user.seller_account) do
    #     column("ID") { |seller| link_to "##{seller.id}", admin_seller_account_path(seller) }
    #     column("Business name") { |seller| "#{seller.seller.name}" }
    #     column("Status") { |seller| status_tag(seller.seller.status) }
    #     column("Subscribtion") { |seller| seller.seller.subscribed? }
    #   end
    # end

    panel "Seller Account" do
      table_for(user.seller_account) do
        column("Seller ID") { |seller| link_to "##{seller.seller.id}", admin_seller_path(seller.seller_id) }
        column("Business name") { |seller| "#{seller.seller.name}" }
        column("Status") { |seller| status_tag(seller.seller.status) }
        column("Subscribtion") { |seller| seller.seller.subscribed? }
      end
    end

    panel "First Visit" do
      attributes_table_for user.first_visit do
        row(:landing_page) { |v| link_to(v.landing_page, v.landing_page, target: :_blank) if v.landing_page }
        row(:referrer) { |v| link_to(v.referrer, v.referrer) if v.referrer }
        row('Time to Confirm') {|v| distance_of_time_in_words(v.user.created_at, v.started_at) }
        row(:location)
        row(:technology)
        row(:utm_source)
        row(:utm_medium)
        row(:utm_term)
        row(:utm_content)
        row(:utm_campaign)
      end
    end

    active_admin_comments
  end



  # New/Edit view
  form do |f|
    f.semantic_errors
    f.inputs "New User" do
      f.input :first_name, :label => "First Name"
      f.input :last_name, :label => "Last Name"
      f.input :email, :label => "Email"
      f.input :password, type: :password, :label => "Password"
    end
    f.actions
  end


  
  # Sidebar information
  sidebar "User Detatils", only: :show do
    attributes_table_for user do
      row("ID") { "#{user.id}" }
      row("Name") { "#{user.full_name}" }
      row("Created") { "#{user.created_at}" }
      row("Confirmed") { "#{user.confirmed_at}" }
    end
  end
end
