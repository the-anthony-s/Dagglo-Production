class ProductsController < ApplicationController
  
  before_action :authenticate_user!, except: [:show, :index]
  # before_action :set_product, only: [:show]
  before_action :set_seller, except: [:show, :index]
  
  layout :seller_dashboard_layout, except: [:show, :index]


  def show
    @product = Product.friendly.find(params[:id])
  end


  def new
    @product = Product.new
  end


  def create
    safely {
      @product = Product.new(product_params)

      if @product.valid?
        
        # Validate Product Barcode with already existed barcodes
        if Product.where(barcode: @product.barcode).present?
          
          # Validate if SellerProduct with the same Product ID exists
          if @seller.seller_products.where(product_id: @product.id).present?
            redirect_to products_seller_path, notice: "#{@product.name} has been already listed in your inventory"
          else
            product = Product.where(barcode: @product.barcode).last
            seller_product = SellerProduct.create(seller_id: @seller.id, product_id: product.id)
            redirect_to edit_inventory_path(seller_product.id), notice: "#{@product.name} already exists on Dagglo. We merged existed product with your account. If you need help, please contact our customer support."
          end
        
        else
          @product.save

          # Add creater ID (Seller ID) for the future reference
          @product.update_attributes(owner_user_id: current_user.id, owner_seller_id: @seller.id)
          seller_product = SellerProduct.create(seller_id: @seller.id, product_id: @product.id)

          redirect_to edit_inventory_path(seller_product.id), notice: "#{@product.name} created"
        end
        
      else
        redirect_to :new, notice: "An error occurred during registration, try again or contact support"
      end
    }
  end



  private


    def product_params
      params.require(:product).permit!
    end


    def set_product
      @product = Product.friendly.find(params[:id])
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
