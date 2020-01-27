class SellersController < ApplicationController

  before_action :authenticate_user!, except: [:show]
  before_action :set_seller, except: [:show, :new, :create]

  layout :seller_dashboard_layout, except: [:show, :new]


  def new
    if current_user.s_account
      redirect_to root_path # redirect to 404 or notice about seller account presence
    else
      @seller = Seller.new
    end
  end


  def create
    safely {
      @seller = current_user.create_seller(seller_params)
      if @seller.save
        SellerAccount.create(user: current_user, seller: @seller, owner: true)
        redirect_to dashboard_seller_path, notice: "#{@seller.name} created"
      else
        render :new, notice: "An error occurred during registration, try again or contact support"
      end
    }
  end


  def destroy
    safely {
      if current_user.s_account.present? && current_user.seller.present?
        @seller = current_user.seller
        @seller.destroy
        redirect_to new_seller_path, notice: "Seller account completely removed"
      else
        redirect_to root_path, notice: "#{current_user.first_name}, only the owner can delete seller account"
      end
    }
  end


  def update
    safely {
      if @seller.update(seller_params)
        redirect_to settings_seller_path, notice: "#{@seller.name} updated"
      else
        redirect_to settings_seller_path, notice: "Something went wrong during #{@seller.name} update"
      end
    }
  end


  def show
    @seller = Seller.friendly.find(params[:id])
  end


  def dashboard
    @activities = PublicActivity::Activity.all.includes(:trackable, :owner).where(recipient_type: "Seller", recipient_id: @seller).order(created_at: :desc).limit(3)
  end


  def products
    @seller_products = @seller.seller_products.includes(:product).all.order(created_at: :desc)
    # @inventory = @seller.inventory_items.includes(:product).all
  end

  
  def account
    @seller_subscription = @seller.subscription
    @seller_accounts = SellerAccount.all.where(seller_id: @seller.id)
  end

  
  def activities
    @activities = PublicActivity::Activity.all.includes(:trackable, :owner).where(recipient_type: "Seller", recipient_id: @seller).order(created_at: :desc)
  end


  def locations
    @seller_locations = @seller.seller_locations.all
  end


  def billing
    @seller_subscription = @seller.subscription
  end



  private

    def set_seller
      @seller = current_user.s_account
    end


    def seller_params
      params.require(:seller).permit!
    end

    def seller_dashboard_layout
      unless user_signed_in? && @seller
        redirect_to root_path, notice: "Page not found"
      else
        "seller"
      end
    end


end
