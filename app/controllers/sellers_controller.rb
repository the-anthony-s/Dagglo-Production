class SellersController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :set_seller, except: [:show, :new, :create]
  layout :seller_dashboard_layout, except: [:show, :new]


  def new
    safely {
      if current_user.s_account
        redirect_to root_path # redirect to 404 or notice about seller account presence
      else
        @seller = Seller.new
      end
    }
  end


  def create
    safely {
      @seller = current_user.build_seller(seller_params)
      if @seller.save
        # @seller.update_attributes(owner_id: current_user.id)
        @seller.seller_accounts.where(user_id: current_user.id, seller_id: @seller.id, role: :owner).first_or_create
        redirect_to home_seller_path, notice: "#{@seller.name} created"
      else
        render :new, notice: "An error occurred during registration, try again or contact support"
      end
    }
  end


  def destroy
    safely {
      if current_user.s_account.present? && current_user.seller.present?
        @seller = current_user.seller
        
        @seller.subscription.cancel unless !@seller.subscription
        @seller.really_destroy! # paranoia gem
        redirect_to new_seller_path, notice: "Seller subscription canceled. #{@seller.name} deleted."
      else
        redirect_to root_path, notice: "#{current_user.first_name}, only the owner can delete seller account"
      end
    }
  end


  def update
    safely {
      if @seller.update(seller_params)
        redirect_to settings_general_seller_path, notice: "#{@seller.name} updated"
      else
        redirect_to settings_general_seller_path, notice: "Something went wrong during #{@seller.name} update"
      end
    }
  end


  def private
    safely {
      @seller.update(private: true)
      redirect_to settings_account_seller_path, notice: "#{@seller.name} is now private. Your profile is hidden from users and search engines. However, you can still take orders from direct customers."
    }
  end


  def public
    safely {
      @seller.update(private: false)
      redirect_to settings_account_seller_path, notice: "#{@seller.name} back online. Your seller profile is now visible to everyone."
    }
  end


  def show
    @seller = Seller.friendly.find(params[:id])
    @seller_products = @seller.seller_products.includes([:product]).all
    impressionist(@seller, "web")
  end


  def home
    @seller_products = @seller.seller_products.includes(:product).order(created_at: :desc).all
    # @team = @seller.seller_accounts.includes(:user).where.not(user_id: current_user).all
    # @activities = PublicActivity::Activity.all.includes(:trackable, :owner).where(recipient_type: "Seller", recipient_id: @seller).last(3)
    # @announcements = Announcement.sellers.all.order(created_at: :desc).limit(3)
  end


  def account
    @subscription = @seller.subscription
    @seller_accounts = SellerAccount.where(seller_id: @seller.id).includes(:user).all
  end


  def activities
    @pagy, @activities = pagy(PublicActivity::Activity.all.includes([:trackable, :owner]).where(recipient_type: "Seller", recipient_id: @seller).order(created_at: :desc), items: 20)
  end


  def announcements
    @announcements = Announcement.sellers.all.order(created_at: :desc)
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
      unless user_signed_in? && current_user.s_account
        redirect_to root_path, notice: "Page not found"
      else
        "seller"
      end
    end


end
