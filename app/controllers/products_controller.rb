class ProductsController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :set_product, only: [:show, :avg_price]
  before_action :set_seller, except: [:show]
  # before_action :convert_search, only: [:show]

  layout :seller_dashboard_layout, except: [:show]


  def show
    @pricing = Pricing.where(product_id: @product.id, created_at: 6.months.ago..Time.now.end_of_month).group_by_month(:created_at).average(:unit_price_cents)
    @pricing_avg = Pricing.where(product_id: @product.id, created_at: Time.now.beginning_of_month..Time.now.end_of_month).average(:unit_price_cents)
    @pricing_min = Pricing.where(product_id: @product.id, created_at: Time.now.beginning_of_month..Time.now.end_of_month).minimum(:unit_price_cents)
    @pricing_max = Pricing.where(product_id: @product.id, created_at: Time.now.beginning_of_month..Time.now.end_of_month).maximum(:unit_price_cents)
    @best = SellerProduct.order(unit_price_cents: :asc).where(product_id: @product.id).includes([:seller]).first
    @recommended = @product.similar(
      fields: ["name", "seller"],
      # track: {user_id: user_signed_in? ? current_user.id : nil, source: "web similar items to #{@product.name}"}
      # where: {status: :active, category_id: @product.category.id}
    ).take(8)
    
    # impressionist(@product, "web")
  end


  def avg_price
    render json: Pricing.where(product_id: @product.id).group_by_month(:created_at).average(:unit_price_cents).chart_json
  end


  def new
    @product = Product.new(category_id: params[:category_id ], barcode: params[:barcode])
  end


  def create
    safely {
      @product = Product.new(product_params)
      gtin = Barkick::GTIN.new("#{@product.barcode}")
      if @product.valid?
        # Validate barcode
        if gtin.valid?
          # Check if similar product present
          if ProductBarcode.where(gtin14: gtin.gtin14, ean13: gtin.ean13, upc: gtin.upc).last.present?
            seller_product = @seller.seller_products.where(product_id: product.id, seller_id: @seller.id).first_or_create
            redirect_to edit_seller_product_path(seller_product.id), :flash => { 'Product exists' => "We found #{@product.name} in our database. Your listing will be merged." }
          else
            @product.save
            seller_product = SellerProduct.where(product_id: @product.id, seller_id: @seller.id).first_or_create
            redirect_to edit_seller_product_path(seller_product.id), :flash => { 'New Product' => "#{@product.name} created. We need more information about your offer."}
          end # Product.where()...
        else
          render :new, :flash => { 'Barcode error' => "#{@product.barcode} is not a valide barcode. Please, try again."}
        end # gtin.valid?
      else
        render :new, notice: "An error occurred during registration, try again or contact support"
      end # @product.valid?
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


  def index
    @categories = Category.is_active.all
  end  


  private

    def convert_search
      return if request.referer.blank?
      referer = CGI::parse(request.referer)['query'][0]
      query_to_convert = Searchjoy::Search.where(normalized_query: referer).last
      query_to_convert.convert(@product) unless query_to_convert.nil?
    end


    def set_product
      @product = Product.friendly.includes(:category).find(params[:id])
    end


    def product_params
      params.require(:product).permit!
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
