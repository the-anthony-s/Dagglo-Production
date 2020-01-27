class SellerPricingController < ApplicationController

  before_action :set_seller

  layout :seller_dashboard_layout
  

  def show
    @seller_plans = SellerPlan.all
  end


  private

    def set_seller
      @seller = current_user.s_account
    end

    def set_plan
      @seller_pricing = SellerPricing.find(params[:id])
    end

    def seller_dashboard_layout
      unless user_signed_in? && @seller
        redirect_to root_path, notice: "Page not found"
      else
        "seller"
      end
    end

end