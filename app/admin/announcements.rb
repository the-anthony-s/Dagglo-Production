ActiveAdmin.register Announcement do


  permit_params :name, :image, :audience, :hide, :content

  scope :users
  scope :sellers
  scope :buyers

  filter :name
  filter :hide
  filter :created_at

  index do
    selectable_column
    id_column
    column :name
    column :hide
    column :audience
    actions
  end


  form do |f|
    f.semantic_errors
    f.inputs "New announcement" do
      f.input :name, label: "Title"
      f.input :content, label: "Announcement message", as: :quill_editor
      f.input :hide, label: "Display?"
      f.input :audience, label: "Show to"
    end
    f.actions
  end



end
