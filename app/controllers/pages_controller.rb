class PagesController < ApplicationController

  def promo
    @categories = Category.all.limit(25)
  end

  def sell
    @seller_plans = SellerPlan.is_active.all.order(created_at: :asc)
  end

  def show
    render template: "pages/#{params[:page]}"
  end
end
