module SearchFallback
    extend ActiveSupport::Concern

    included do

        rescue_from ActiveRecord::RecordNotFound do |exception|
            @query = params[:id].gsub(/[^\w-]/, '')
            @product = Product.where("name LIKE ? OR slug LIKE ?", "%#{@query}", "%#{@query}")
            render '/searches/show'
        end

    end

end