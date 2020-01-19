class Seller < ApplicationRecord

  belongs_to :owner, class_name: "User"

  has_many :seller_accounts, dependent: :delete_all



  # Mandatory fields
  validates_presence_of :name

end
