class ProductsController < ApplicationController

  before_action :authenticate_user!, except: [:show, :index]
  before_action :set_product, only: [:show]
  before_action :set_seller, except: [:show, :index]
  before_action :convert_search, only: [:show, :show_product]

  layout :seller_dashboard_layout, except: [:show, :index]


  def show
      @offers = @product.seller_products.all
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
          product = Product.where(barcode: @product.barcode).last
          seller_product = SellerProduct.create(seller_id: @seller.id, product_id: product.id)
          redirect_to edit_inventory_path(seller_product.id), notice: "#{@product.name} already exists on Dagglo. We merged existed product with your account."
        else
          @product.save
          seller_product = SellerProduct.create(seller_id: @seller.id, product_id: @product.id)
          redirect_to edit_inventory_path(seller_product.id), notice: "#{@product.name} created"
        end
      else
        render :new, notice: "An error occurred during registration, try again or contact support"
      end
    }
  end


  def update
    safely {
      if @product.update(product_params)
        redirect_to products_seller_path, notice: "#{@product.name} updated"
      else
        render :edit, notice: "Something went wrong during #{@product.name} update"
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


    def convert_search
      return if request.referer.blank?
      referer = CGI::parse(request.referer)['query'][0]
      query_to_convert = Searchjoy::Search.where(normalized_query: referer).last
      query_to_convert.convert(@product) unless query_to_convert.nil?
    end

end
