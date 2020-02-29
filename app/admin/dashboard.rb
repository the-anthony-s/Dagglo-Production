ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do
    
    columns do
      column do
        panel "Recent User" do
          table_for User.order("created_at desc").limit(10) do
            column("Full name") { |user| link_to(user.full_name, admin_user_path(user)) }
            column("Confirmation") { |user| status_tag(user.confirmed_at) }
          end
        end
      end

      column do
        panel "Recent Sellers" do
          table_for Seller.order("created_at desc").limit(10) do
            column("Business name") { |seller| link_to(seller.name, admin_seller_path(seller)) }
          end
        end
      end
    end # columns


    columns do
      column do
        panel "Recent Products" do
          table_for Product.order("created_at desc").includes(:category).limit(10) do
            column("Name") { |product| link_to(product.name, admin_product_path(product)) }
            column("Category") { |product| link_to(product.category.name, admin_category_path(product.category)) }
            column("Pause") { |product| status_tag(product.status) }
          end
        end
      end
    end # columns


    columns do
      column do
        panel "Recent activities" do
          table_for Ahoy::Event.order("time desc").limit(10) do
            column("Name") { |event| event.name }
            column("User ID") { |event| link_to(event.user_id, admin_user_path(event.user_id)) unless event.user_id == nil }
            column("Time") { |event| event.time }
          end
        end
      end
    end


    columns do
      column do
        panel "Recent visits" do
          table_for Ahoy::Visit.order("started_at desc").limit(10) do
            column("Country") { |visit| visit.country }
            column("User ID") { |visit| link_to(visit.user_id, admin_user_path(visit.user_id)) unless visit.user_id == nil }
            column("Time") { |visit| visit.started_at }
          end
        end
      end
    end

  end # content
end
