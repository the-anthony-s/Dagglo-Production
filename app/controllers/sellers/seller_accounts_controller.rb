class Sellers::SellerAccountsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_seller_account, only: [:edit, :update, :destroy, :show]
  before_action :set_seller

  layout :seller_dashboard_layout


  def new
  end


  def create
    seller_account = @seller.seller_accounts.new(seller_account_params)
    seller_account.seller = @seller

    if seller_account.save
      redirect_to settings_account_seller_path, notice: "Success"
    else
      render :new, alert: "Fail"
    end
  end


  def show
    @activities = PublicActivity::Activity.all.includes(:trackable, :owner).where(owner_type: "User", owner_id: @seller_account.user, recipient_id: @seller_account.seller).limit(3).order(created_at: :desc)
  end



  private

    def seller_account_params
      params.require(:seller_account).permit(:email)
    end


    def set_seller_account
      @seller_account = SellerAccount.find(params[:id])
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
