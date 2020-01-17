class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :trackable, :confirmable

  
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
end
