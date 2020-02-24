class Term < ApplicationRecord

    def last_update
        "#{updated_at.strftime("%B %d, %Y")}"
    end

end
