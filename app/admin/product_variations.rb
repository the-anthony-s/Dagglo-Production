ActiveAdmin.register ProductVariation do

	# belongs_to :category
	permit_params :name, :field_type, :required, :category_id
	


	# New/Edit view
	form do |f|
		f.semantic_errors
		f.inputs "New Product" do
			f.input :name, :label => "Variation name"
			f.input :field_type, :label => "Field type", :as => :select, :collection => %w[text_field]
			f.input :category_id, :label => "Category", :as => :select, :collection => Category.all.map{ |cateogry| ["#{cateogry.name}", cateogry.id] }
			f.input :required, label: "Required variation"
		end
		f.actions
	end
  
end
