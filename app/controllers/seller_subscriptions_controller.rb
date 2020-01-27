class SellerSubscriptionsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_seller
  before_action :set_seller_plan, only: [:new, :create, :update]

  layout :seller_dashboard_layout


  def new
  end


  def create
    @seller.update_seller_card(params[:payment_method_id]) if params[:payment_method_id].present?
    @seller.subscribe(@seller_plan.stripe_id)
    
    redirect_to dashboard_seller_path, notice: "#{current_user.first_name}, thank you for subscribing"
  rescue PaymentIncomplete => e
    redirect_to seller_payment_path(e.payment_intent.id)
  end


  def edit
    @seller_subscription = @seller.subscription
    @seller_plans = SellerPlan.all
  end


  def update
    @seller_subscription = @seller.subscription
    @seller_subscription.swap(@seller_plan.stripe_id)
    redirect_to settings_account_seller_path, notice: "#{current_user.first_name}, you have successfully changed plan"
  end


  def destroy
    @seller.subscription.cancel
    redirect_to settings_billing_seller_path, notice: "#{current_user.first_name}, your subscription has been canceled"
  end


  def resume
    @seller.subscription.resume
    redirect_to settings_billing_seller_path, notice: "#{current_user.first_name}, your seller subscription has been resumed"
  end


  private

    def set_seller_plan
      @seller_plan = SellerPlan.find_by(id: params[:plan_id])
      redirect_to seller_pricing_path if @seller_plan.nil?
    end


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