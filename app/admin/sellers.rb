ActiveAdmin.register Seller do

  menu priority: 3

  
  permit_params do
    permitted = [:name, :business_number, :about, :country, :founding_date, :status, :private, :image, :cover, :stripe_id]
    # permitted << :other if params[:action] == 'create' && current_user.admin?
    # permitted
  end


  filter :owner_id
  filter :name
  filter :business_number
  filter :country
  filter :created_at


  scope :all, :default => true
  scope :pending
  scope :active
  scope :paused
  scope :banned


  # Table view
  index do
    selectable_column
    column("ID", :sortable => :id) { |seller| "##{seller.id}" }
    column("Business name") { |seller| link_to "#{seller.name}", admin_seller_path(seller) }
    column("Status") { |seller| status_tag(seller.status) }
    column("Subscribtion") { |seller| seller.subscribed? }
    actions
  end


  # Show view
  show title: :name do
    # seller_subscriptions, seller_charges

    panel "Inventory Products" do
      table_for(seller.seller_products) do
        column("ID", sortable: :id) { |i| link_to "#{i.id}", admin_seller_seller_product_path(i) }
        column("Product") { |i| link_to "#{i.product.name}", admin_product_path(i.product) }
        # column("Inventory status") { |i| "#{i.status}" }
        column("Product status") { |i| status_tag(i.product.status) }
        column("Unit price") { |i| "#{number_to_currency i.unit_price}" }
      end
    end

    panel "Locations" do
      table_for(seller.seller_locations) do
        column("Title") { |l| link_to "#{l.title}", admin_seller_seller_location_path(l) }
        column("Address") { |l| "#{l.address}" }
        column("City") { |l| "#{l.city}" }
        column("State") { |l| "#{l.state}" }
        column("Country") { |l| "#{l.country}" }
        column("ZIP code") { |l| "#{l.zip}" }
        column("Private") { |l| status_tag(l.private) }
      end
    end

    panel "Connected Accounts" do
      table_for(seller.seller_accounts.includes(:user)) do
        column("Name") { |ca| link_to "#{ca.user.full_name}", admin_user_path(ca.user) }
        column("Email") { |ca| "#{ca.user.email}" }
      end
    end

    active_admin_comments
  end


  # New/Edit view
  form do |f|
    f.inputs "New Seller" do
      # f.input :owner_id, :label => "Account owner", :as => :select, :collection => User.all.map{|c| ["#{c.full_name}", c.id]}, :include_blank => true
      f.input :name, :label => "Business name"
      f.input :image, as: :file, input_html: { multiple: false }, :label => "Account Logo"
      f.input :cover, as: :file, input_html: { multiple: false }, :label => "Cover Image"
      f.input :about, :label => "Account description"
      f.input :country, :include_blank => true, :label => "Heahoffice country"
      f.input :founding_date, :label => "Founding date", as: :datepicker, datepicker_options: { min_date: "1960-01-1", max_date: "+3D" }
      f.input :status, as: :select, :label => "Account status"
      f.input :private, :label => "Private seller activity"
    end
    f.actions
  end



  # Sidebar information
  sidebar "Seller Details", only: :show do
    attributes_table_for seller, :business_number, :country, :created_at, :subscribed?, :status
  end
  
end
