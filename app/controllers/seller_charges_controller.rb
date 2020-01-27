class SellerChargesController < ApplicationController

  before_action :authenticate_user!
  before_action :set_seller
  before_action :set_seller_charge

  layout :seller_dashboard_layout


  def show
    respond_to do |format|
      format.pdf {
        send_data @seller_charge.receipt.render,
        filename: @seller_charge.filename,
        type: "application/pdf",
        disposition: :inline
      }
    end
  end



  private

    def set_seller
      @seller = current_user.s_account
    end


    def set_seller_charge
      @seller_charge = @seller.seller_charges.find(params[:id])
    end


    def seller_dashboard_layout
      unless user_signed_in? && @seller
        redirect_to root_path, notice: "Page not found"
      else
        "seller"
      end
    end
    

end