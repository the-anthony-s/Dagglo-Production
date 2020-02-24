class PagesController < ApplicationController

  def promo
    @categories = Category.all.limit(25)
  end

  def sell
    @seller_plans = SellerPlan.is_active.all.order(created_at: :asc)
    @categories = Category.all.limit(25)
  end

  def terms
  end

  def privacy
  end

end
