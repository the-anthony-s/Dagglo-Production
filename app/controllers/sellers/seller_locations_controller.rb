class Sellers::SellerLocationsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_seller_location, only: [:destroy, :edit, :update, :show]
  before_action :set_seller

  layout :seller_dashboard_layout


  def show
    @members = SellerAccount.where(seller_location_id: @seller_location, seller_id: @seller).includes(:user).all
    @activities = PublicActivity::Activity.all.includes(:trackable, :owner).where(trackable_type: "SellerLocation", trackable_id: @seller_location, recipient_id: @seller_location.seller_id).limit(5).order(created_at: :desc)
  end


  def index
    @locations = @seller.seller_locations.all
  end


  def new
    @seller_location = SellerLocation.new
  end


  def create
    @seller_location = @seller.seller_locations.build(seller_location_params)

    if @seller_location.save
      # redirect_to seller_location_path(@seller_location), flash: {"Success" => "#{@seller_location.name} created"}
      redirect_to seller_locations_path, flash: {"Success" => "#{@seller_location.name} created"}
    else
      render :new, flash: {"Location Error" => "Something went wrong. Please try again."}
    end
  end


  def destroy
    SellerAccount.where(seller_id: @seller, seller_location_id: @seller_location).update_all(seller_location_id: nil)
    @seller_location.destroy
    redirect_to seller_locations_path, flash: {"Success" => "Location removed"}
  end


  def edit
  end


  def update
    if @seller_location.update(seller_location_params)
      # redirect_to seller_location_path(@seller_location), notice: "#{@seller_location.name} updated"
      redirect_to seller_locations_path, notice: "#{@seller_location.name} updated"
    else
      render :edit, flash: {"Update Error" => "Something went wrong. Please try again."}
    end
  end


  private

    def set_seller
      @seller = current_user.s_account
    end

    def set_seller_location
      @seller_location = SellerLocation.where(seller_id: current_user.s_account.id).find(params[:id])
    end

    def seller_location_params
      params.require(:seller_location).permit!
    end

    def seller_dashboard_layout
      unless user_signed_in? && @seller
        redirect_to root_path, notice: "Page not found"
      else
        "seller"
      end
    end

end
