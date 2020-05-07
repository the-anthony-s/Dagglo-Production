class Users::UserLocationsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_user_location, only: [:edit, :update, :destroy]

    def new
        @user_location = UserLocation.new
    end


    def create
        @user_location = current_user.user_locations.new(user_location_params)

        if @user_location.save
            redirect_to user_locations_path, notice: "New shipping address added"
        else
            render :new, alert: "Something went wrong, please try again"
        end
    end


    def destroy
        @user_location.destroy
        redirect_to user_locations_path, notice: "Shipping address removed"
    end


    def update
        if @user_location.update(user_location_params)
            redirect_to user_locations_path, notice: "Shipping address updated"
        else
            render :edit, alert: "Something went wrong, please try again"
        end
    end


    def index
        @user_locations = current_user.user_locations.all
    end



    private

        def set_user_location
            @user_location = UserLocation.find(params[:id])
        end

        def user_location_params
            params.require(:user_location).permit!
        end

end
