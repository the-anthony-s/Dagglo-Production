class ContactsController < ApplicationController
  invisible_captcha only: [:create], honeypot: [:email, :message], on_spam: :on_spam


  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)

    if @contact.save
      ContactsMailer.general_message(@contact).deliver
      redirect_to new_contact_path, notice: "Email sent. Thank you, #{@contact.first_name}"
    else
      redirect_to new_contact_path, notice: "Something went wrong. Please, try again or send direct email: help@dagglo.com"
    end
  end

  private

    def contact_params
      params.require(:contact).permit(:first_name, :last_name, :email, :phone_number, :message, :company)
    end

    def on_spam
      redirect_to new_contact_path, flash: "Our system thinks that you are bot. Please, send us direct email: help@dagglo.com"
    end
end
