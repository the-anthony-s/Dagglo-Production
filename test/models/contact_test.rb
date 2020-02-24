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
require 'test_helper'

class ContactTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
