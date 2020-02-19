class ContactsMailer < ApplicationMailer

  default from: "help@dagglo.com"


  def mandrill_client
    # go to mail.rb for Mandrill configurations
    @mandrill_client ||= Mandrill::API.new MANDRILL_API_KEY
  end


  def general_message(contact)
    @contact = contact
    mail(:to => "helo@dagglo.com", :subject => "#{contact.first_name} from Dagglo")
  end

end
