class ChartsController < ApplicationController

    def avg_price
        render json: Pricing.group_by_month(:created_at).average(:unit_price_cents)
    end

end