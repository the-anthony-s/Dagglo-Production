class Sellers::SellerProductsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_seller_product, only: [:destroy, :edit, :update, :show]
  before_action :set_seller

  layout :seller_dashboard_layout


  def index
    @seller_products = @seller.seller_products.all
  end


  def show
    @activities = PublicActivity::Activity.all.includes(:trackable, :owner).where(trackable_type: "SellerProduct", trackable_id: @seller_product, recipient_id: @seller_product.seller_id).limit(5).order(created_at: :desc)
  end


  def new
    @seller_product = SellerProduct.new
  end


  def create
    safely {
      @seller_product = SellerProduct.new(seller_product_params)
      if @seller_product.save
        redirect_to @seller_product, :flash => { "Inventory Created" => "#{@seller_product.product.name} updated" }
      else
        render :new, :flash => { "Product Error" => "Something went wrong during the registration. Please, try again or contact our support." }
      end
    }
  end


  def edit
    @barcode = ProductBarcode.where(product_id: @seller_product.product.id).last
  end


  def update
    safely {
      if @seller_product.update(seller_product_params)
        render :show, :flash => { "Product Update" => "#{@seller_product.product.name} updated" } 
      else
        render :edit, :flash => { "Product Update Error" => "Something went wrong during the update. Please, try again or contact our customer support."}
      end
    }
  end


  def destroy
    safely {
      # @seller_product.product.update_attribute(:num_offers, SellerProduct.where(product_id: @seller_product.product.id).count)
      # @seller_product.product.update_attribute(:min_amount, SellerProduct.where(product_id: @seller_product.product.id).minimum(:unit_price))

      @seller_product.really_destroy!
      redirect_to seller_products_path, :flash => { "Product Deleted" => "#{@seller_product.product.name} removed from your inventory" }
    }
  end


  private


    def seller_product_params
      params.require(:seller_product).permit!
    end


    def set_seller_product
      @seller_product = SellerProduct.includes(:product).find(params[:id])
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
