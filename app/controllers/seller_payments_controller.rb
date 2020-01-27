class SellerPaymentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_seller
  before_action :set_seller_payment

  layout :seller_dashboard_layout

  def show
  end

  def update
    redirect_to dashboard_seller_path, notice: "#{current_user.first_name}, thank you for your subscribtion"
  end


  private

    def set_seller
      @seller = current_user.s_account    
    end

    def set_seller_payment
      @seller_payment_intent = Stripe::PaymentIntent.retrieve(params[:id])
    end


    def seller_dashboard_layout
      unless user_signed_in? && @seller
        redirect_to root_path, notice: "Page not found"
      else
        "seller"
      end
    end

end