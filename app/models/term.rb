# == Schema Information
#
# Table name: terms
#
#  id         :bigint           not null, primary key
#  name       :string
#  content    :text
#  pause      :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Term < ApplicationRecord

    def last_update
        "#{updated_at.strftime("%B %d, %Y")}"
    end

end
