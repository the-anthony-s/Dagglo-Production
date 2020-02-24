# == Schema Information
#
# Table name: carriers
#
#  id             :bigint           not null, primary key
#  first_name     :string
#  last_name      :string
#  business_name  :string
#  business_email :string
#  phone          :string
#  country        :string
#  state          :string
#  num_of_trucks  :integer
#  comment        :text
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
class Carrier < ApplicationRecord
    has_and_belongs_to_many :carrier_trucks
end
