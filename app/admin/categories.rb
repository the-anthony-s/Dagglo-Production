ActiveAdmin.register Category do


  permit_params :name, :ancestry, :type_of_products, :conditions_allowed, :approval_required, :cover, :pause


  filter :title
  filter :products
  filter :created_at


  # All categories -> Index view
  index do
    selectable_column
    column("ID", sortable: :id) { |category| link_to "##{category.id}", admin_category_path(category) }
    column("Name") { |category| "#{category.name}" }
    column("Ancestry") { |category| "#{category.ancestry}" }
    column("Pause") { |category| status_tag(category.pause) }
    actions
  end
  

  # Show view
  show title: :name do
    panel "Products" do
      table_for(category.products) do
        column("ID", sortable: :id) { |product| link_to "##{product.id}", admin_product_path(product) }
        column("Name") { |product| "#{product.name}" }
        column("Status") { |product| status_tag(product.status) }
      end
    end

    active_admin_comments
  end


  # Edit/New View
  form do |f|
    f.inputs "New Category" do
      f.input :name, label: "Category title"
      f.input :type_of_products, label: "Type of products", as: :quill_editor
      f.input :conditions_allowed, label: "Condition", as: :quill_editor
      f.input :approval_required, label: "Need approvel?", as: :quill_editor
      f.input :ancestry, :label => "Ancestry category", :as => :select, :collection => Category.all.map{|c| ["#{c.name}", c.id]}
      f.input :cover, as: :file, input_html: { multiple: false }, label: "Cover image"
      f.input :pause, label: "Pause category"
    end
    f.actions
  end


  # Sidebar information
  sidebar "Category Details", only: :show do
    attributes_table_for category do
      row("ID") { "#{category.id}" }
      row("Name") { "#{category.name}" }
      row("Ancestry") { "#{category.ancestry}" }
      row("Pause") { status_tag(category.pause) }
    end
  end


end
