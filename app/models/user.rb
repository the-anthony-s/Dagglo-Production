class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :trackable, :confirmable



  # Database refereces
  has_one :seller, dependent: :delete, foreign_key: :owner_id # -> seller account
  has_one :seller_account


  
  validates_presence_of :first_name, :last_name


  
  # Return User's full name
  def full_name
    "#{first_name} #{last_name}" unless !first_name.present? && !last_name.present?
  end



  # Return image_data -> Avatar or Default
  def avatar(height = nil, width = nil)
    if image_data.present?
      # if (height != nil) && (width != nil)
      #   image.derivation_url(:thumbnail, height, width).to_s
      # else
      #   image.url
      # end
      false
    else
      ActionController::Base.helpers.asset_path("defaults/" + ["avatar.png"].compact.join('_'))
    end
  end



  # Seller Account
  def s_account
    if seller_account.present?
      seller_account.seller
    end
  end



  # User Greetings
  def hello
    case Time.zone.now.hour
    when 4..11 then 'Morning'
    when 12..17 then 'Good afternoon'
    when 18..23 then 'Evening'
    else
      'Hi'
    end
  end

end
