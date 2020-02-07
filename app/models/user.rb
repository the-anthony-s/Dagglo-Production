# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  first_name             :string           default(""), not null
#  last_name              :string           default(""), not null
#  phone_number           :string
#  time_zone              :string
#  image_data             :string
#  private                :boolean          default(FALSE)
#  status                 :integer          default(0)
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  failed_attempts        :integer          default(0), not null
#  unlock_token           :string
#  locked_at              :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :trackable, :confirmable



  # Database refereces
  has_one :seller_account
  has_one :seller, through: :seller_account



  validates_presence_of :first_name, :last_name



  # Return User's full name
  def full_name
    "#{first_name} #{last_name}" unless !first_name.present? && !last_name.present?
  end



  # Return image_data -> Avatar or Default
  include ImageUploader::Attachment(:image)

  def avatar(height = nil, width = nil)
    if image_data.present?
      if (height != nil) && (width != nil)
        image.derivation_url(:thumbnail, height, width).to_s
      else
        image.url
      end
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
