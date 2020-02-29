class PagesController < ApplicationController

  def home
    @products = Product.all
  end

  def promo
    @categories = Category.all.limit(25)
  end

  def sell
    @seller_plans = SellerPlan.is_active.all.order(created_at: :asc)
    @categories = Category.all.limit(25)
  end

  def terms
    @terms = Term.last
  end

  def privacy
    @privacy = Privacy.last
  end

end
