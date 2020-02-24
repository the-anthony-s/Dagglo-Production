ActiveAdmin.register Privacy do
  
  permit_params :name, :content, :pause

  index do
    selectable_column
    id_column
    column :name
    column :pause
    actions
  end


  form do |f|
    f.inputs "Privacy" do
      f.input :name
      f.input :content, as: :quill_editor
      f.input :pause
    end
    f.actions
  end

end
