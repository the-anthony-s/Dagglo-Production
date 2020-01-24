class SellerProductsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_seller_product, only: [:destroy, :edit, :update, :show]
  before_action :set_seller
  
  layout :seller_dashboard_layout


  def show
  end


  def new
    @seller_product = SellerProduct.new
  end

  
  def create
    safely {
      @seller_product = SellerProduct.new(seller_product_params)
      if @seller_product.save
        redirect_to @seller_product, notice: "#{@seller_product.product.name} updated"
      else
        render :new, notice: "Something went wrong during the registration. Please, try again or contact our support."
      end
    }
  end


  def edit
  end


  def update
    safely {
      if @seller_product.update(seller_product_params)
        # @seller_product.product.update_attribute(:num_offers, SellerProduct.where(product_id: @seller_product.product.id).count)
        # @seller_product.product.update_attribute(:min_amount, SellerProduct.where(product_id: @seller_product.product.id).minimum(:unit_price))
        
        render :show, notice: "#{@seller_product.product.name} updated"
      else
        render :edit, notice: "Something went wrong during the update. Please, try again or contact our customer support."
      end
    }
  end


  def destroy
    safely {
      # @seller_product.product.update_attribute(:num_offers, SellerProduct.where(product_id: @seller_product.product.id).count)
      # @seller_product.product.update_attribute(:min_amount, SellerProduct.where(product_id: @seller_product.product.id).minimum(:unit_price))

      @seller_product.destroy
      redirect_to products_seller_path, notice: "Product removed from your inventory"
    }    
  end


  private


    def seller_product_params
      params.require(:seller_product).permit!
    end


    def set_seller_product
      @seller_product = SellerProduct.find(params[:id])
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
