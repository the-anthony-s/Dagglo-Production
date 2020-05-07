# == Schema Information
#
# Table name: user_locations
#
#  id         :bigint           not null, primary key
#  name       :string
#  street     :string
#  city       :string
#  zip        :string
#  state      :string
#  country    :string
#  longitude  :float
#  latitude   :float
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint
#  deleted_at :datetime
#
require 'test_helper'

class UserLocationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
