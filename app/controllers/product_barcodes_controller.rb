class ProductBarcodesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_seller

    layout :seller_dashboard_layout


    def new
        @barcode = ProductBarcode.new
    end


    def create
        safely {
            @barcode = ProductBarcode.new(barcode_params)
            gtin = Barkick::GTIN.new(@barcode.barcode)

            if gtin.valid? && @barcode.valid?
                if ProductBarcode.where(gtin14: gtin.gtin14, ean13: gtin.ean13, upc: gtin.upc).last.present?
                    barcode = ProductBarcode.where(gtin14: gtin.gtin14, ean13: gtin.ean13, upc: gtin.upc).last
                    product = barcode.product
                    seller_product = SellerProduct.where(product_id: product.id, seller_id: @seller.id).first_or_create
                    redirect_to edit_seller_product_path(seller_product.id), :flash => { 'Product exists' => "We found #{product.name} in our database. Your listing will be merged." }
                else
                    # redirect to Product Index (Choose Category) if nothing found
                    redirect_to products_path(barcode: @barcode.barcode), :flash => { 'Product Search' => "#{@barcode.barcode} doesn't exist on Dagglo" }
                end
            else
                redirect_to new_product_barcode_path, :flash => { "Invalid Barcode" => "Barcode is not valid. Please, try again."}
            end
        }
    end

    

    private

        def barcode_params
            params.require(:product_barcode).permit(:barcode)
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