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
end
