# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
    before_action :authenticate_user!
    before_action :set_user

    # prepend_before_action :check_captcha, only: [:create]


    def preferences
        if @user
            render :preferences
        else
            root_path
            # not_found
        end
    end


    def security
        if @user
            render :security
        else
            root_path
            # not_found
        end
    end


    def activity
        if @user
            @sessions = Ahoy::Visit.order(started_at: :asc).where(user_id: @user).last(10)
            render :activity
        else
            root_path
            # not_found
        end
    end


    def favorites
        @product_likes = current_user.product_likes.includes(:product).all
    end


    private

        def set_user
            @user = current_user
        end

        # Adding new fields to Seller registration process
        def sign_up_params
            params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :time_zone)
        end

        def account_update_params
            params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :current_password, :image, :time_zone)
        end

        def on_spam
            redirect_to new_contact_path, flash: "Our system thinks that you are bot. Please, contact our customer support."
        end

        # https://github.com/heartcombo/devise/wiki/How-To:-Use-Recaptcha-with-Devise
        def check_captcha
            unless verify_recaptcha
                self.resource = resource_class.new sign_up_params
                resource.validate # Look for any other validation errors besides reCAPTCHA
                set_minimum_password_length
                respond_with_navigational(resource) { render :new }
            end 
        end


    protected

        # Allow Sellers to update account without current_password
        def update_resource(resource, params)
            # Require current password if user is trying to change password.
            return super if params["password"]&.present?
            # Allows user to update registration information without password.
            resource.update_without_password(params.except("current_password"))
        end


        # Redirect user after each setting update
        def after_update_path_for(resource)
            flash[:notice] =  "Account succesfully updated"
            edit_user_registration_path
        end


        # Action after user confirmed the email
        # def after_confirmation
        #   UserMailer.welcome_email(self).deliver_later
        # end

end
