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
      redirect_to settings_account_seller_path, notice: "#{seller_account.user.full_name || seller_account.user.email} invited to #{seller_account.seller.name}"
    else
      render :new, alert: "Fail"
    end
  end


  def destroy
    if current_user.seller_account.role == "owner"
      @seller_account.destroy
      redirect_to settings_account_seller_path, notice: "#{@seller_account.user.full_name || @seller_account.user.email} removed from #{@seller.name}"
    else
      redirect_to dashboard_seller_path, notice: "You don't have access to delete users from #{@seller.name}"
    end
  end


  def show
    @activities = PublicActivity::Activity.all.includes(:trackable, :owner).where(owner_type: "User", owner_id: @seller_account.user, recipient_id: @seller_account.seller).limit(3).order(created_at: :desc)
  end



  private

    def seller_account_params
      params.require(:seller_account).permit(:email, :role)
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
