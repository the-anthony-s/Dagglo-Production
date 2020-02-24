# == Schema Information
#
# Table name: categories
#
#  id                 :bigint           not null, primary key
#  name               :string
#  ancestry           :string
#  type_of_products   :text
#  conditions_allowed :text
#  approval_required  :text
#  cover_data         :text
#  pause              :boolean          default("false")
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  slug               :string
#

require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
