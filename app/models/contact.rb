# == Schema Information
#
# Table name: contacts
#
#  id           :bigint           not null, primary key
#  first_name   :string
#  last_name    :string
#  company      :string
#  email        :string
#  phone_number :string
#  message      :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class Contact < ApplicationRecord

    validates :first_name, :presence => true
    validates :last_name, :presence => true
    validates :email,
        :presence => :true,
        :format => {
            :with => /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i,
            :message => "Must be a valid email address"
        }
    validates :message, :presence => :true

end
