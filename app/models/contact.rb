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
