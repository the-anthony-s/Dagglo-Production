class CarriersController < ApplicationController

    # invisible_captcha only: [:create], honeypot: [:email, :company], on_spam: :on_spam


    def new
        @carrier = Carrier.new
    end


    def edit
    end

    def create
        @carrier = Carrier.new(carrier_params)

        if @carrier.save
            redirect_to root_path, notice: "Thank you for your application. We will get in touch with you soon."
        else
            render :index, alert: "Something went wrong"
        end
    end



    private

        def set_carrier
            @carrier = Carrier.find(params[:id])
        end

        def carrier_params
            # params.require(:carrier).permit(:name, :business_email, :phone, :country, :state, :num_of_trucks, carrier_truck_ids: [])
            params.require(:carrier).permit!
        end

end
