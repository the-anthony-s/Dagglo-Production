class SellerCardsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_seller

  layout :seller_dashboard_layout

  def edit
    @setup_intent = @seller.create_setup_intent
  end

  def update
    @seller.update_seller_card(params[:payment_method_id])
    redirect_to edit_seller_card_path, notice: "#{current_user.first_name}, credit card was successfully updated"
  rescue Stripe::Error => e
    redirect_to edit_seller_card_path, notice: "Our payment processor returned the following error: #{e.message}"
  end

  private

    def set_seller
      @seller = current_user.s_account
    end

    def seller_dashboard_layout
      unless user_signed_in? && @seller
        redirect_to root_path, notice: "Page not found"
      else
        "seller"
      end
    end

end