class SellerAccountsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_seller_account, only: [:destroy, :show]
  before_action :set_seller

  layout :seller_dashboard_layout


  def show
    @activities = PublicActivity::Activity.all.includes(:trackable, :owner).where(owner_type: "User", owner_id: @seller_account.user, recipient_id: @seller_account.seller).limit(3)
  end



  private

    def seller_account_params
      
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
