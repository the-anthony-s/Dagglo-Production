ActiveAdmin.register Product do

  permit_params :name, :barcode, :about, :country, :min_price, :num_of_sellers, :manufacturer_warranty, :status, :category_id, :owner_user_id, :owner_seller_id, image: []


  filter :name
  filter :category
  filter :country
  filter :barcode
  filter :manufacture_warrenty
  filter :created_at


  scope :all, :default => true
  scope :pending
  scope :active
  scope :paused
  scope :banned


  index do
    selectable_column
    column("ID", :sortable => :id) { |product| "##{product.id}" }
    column("Title", :name) { |product| link_to "#{product.name}", admin_product_path(product) }
    column("Barcode", :barcode) { |product| "#{product.barcode}" }
    # column("Sellers", :num_of_sellers) { |product| "#{product.num_of_sellers}" }
    column("Status", :status) { |product| status_tag(product.status) }
    actions
  end



  show title: :name do
    panel "Connected Inventory" do
      table_for(product.seller_products.includes(:seller)) do
        column("ID", sortable: :id) { |p| link_to "#{p.id}", admin_seller_inventory_item_path(p) }
        column("Seller") { |p| link_to "#{p.seller.name}", admin_seller_path(p.seller) }
        column("Unit price") { |p| number_to_currency p.unit_price }
        column("Created at") { |p| p.created_at }
        column("Status") { |p| status_tag(p.pause) }
      end
    end

    panel "Recent Orders" do
    end

    active_admin_comments
  end



  # New/Edit view
  form do |f|
    f.semantic_errors
    f.inputs "New Product" do
      f.input :name, :label => "Product name"
      f.input :barcode, :label => "Manufacture barcode"
      f.input :about, :label => "Product description", as: :quill_editor
      f.input :country, :label => "Country of origin", :include_blank => true
      f.input :category_id, :label => "Product category", :as => :select, :collection => Category.all.map{ |cateogry| ["#{cateogry.name}", cateogry.id] }
      f.input :image, :label => "Product photos", as: :file, input_html: { multiple: true }
      f.input :status, :label => "Product status", as: :select
      # f.input :photos, as: :file, input_html: { multiple: true }, accept: ImageUploader::ALLOWED_TYPES.join(","), data: { upload_server: upload_server }
    end
    f.actions
  end



  # Sidebar information
  sidebar "Product Details", only: :show do
    attributes_table_for product do
      row("Title") { "#{product.name}" }
      row("Barcode") { "#{product.barcode}" }
      row("Category") { link_to "#{product.category.name}", admin_category_path(product.category) }
      row("Date") { "#{product.created_at}" }
      row("Country") { "#{product.country}" }
      row("Status") { status_tag(product.status) }
      row("User ID") { "#{product.owner_user_id}" }
      row("Seller ID") { "#{product.owner_seller_id}" }
      # row("Total Orders") { user.orders.complete.count }
      # row("Total Value") do
      #   number_to_currency user.orders.complete.sum(:total_price)
      # end
    end
  end
  
end
