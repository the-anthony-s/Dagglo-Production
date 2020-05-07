class PagesController < ApplicationController

  def root
    @categories = Category.popular.is_active.roots
    @popular_products = Product.includes(:product_photos).popular.is_active.take(5)
    @new_products = Product.includes(:product_photos).is_new.is_active.take(5)

    # if user_signed_in?
    #   @searches = Searchjoy::Search.select(
    #     :normalized_query, 
    #     :query, 
    #     :results_count, 
    #     :search_type
    #   ).where.not(
    #     query: "",
    #     normalized_query: "", 
    #     source: "web similar items"
    #   ).order(created_at: :desc).limit(4)
    # end
  end


  def home
    @categories = Category.all.take(3)
  end


  def partner
    @seller_plans = SellerPlan.all.order(created_at: :asc)
    @categories = Category.is_active.all
  end


  def terms
    @terms = Term.last
  end

  
  def privacy
    @privacy = Privacy.last
  end

end
