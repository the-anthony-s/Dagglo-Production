class SearchesController < ApplicationController

  def show
    @products = Product.all.order(created_at: :desc)
    search = params[:query].present? ? params[:query] : nil

    if search
      @products = Product.search(
        search,
        fields: ["name^10"],
        track: {user_id: user_signed_in? ? current_user.id : nil, source: "web search"},
        suggest: true,
        match: :text_middle
      ).results
    else
      redirect_back(fallback_location: root_path)
    end
  end

end
