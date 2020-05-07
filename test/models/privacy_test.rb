# == Schema Information
#
# Table name: privacies
#
#  id         :bigint           not null, primary key
#  name       :string
#  content    :text
#  pause      :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'test_helper'

class PrivacyTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
