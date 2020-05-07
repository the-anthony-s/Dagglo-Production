class Products::ProductLikesController < ApplicationController

    before_action :authenticate_user!
    before_action :set_product

    def create
        @product.product_likes.where(user_id: current_user.id).first_or_create
        respond_to do |format|
            format.html { redirect_to show_product_path(@product) }
            format.js { render 'create', layout: false }
        end
    end


    def destroy
        @product.product_likes.where(user_id: current_user.id).destroy_all
        respond_to do |format|
            format.html { redirect_to show_product_path(@product) }
            format.js { render 'destroy', layout: false }
        end
    end


    private

        def set_product
            @product = Product.friendly.find(params[:product_id])
        end

end
