class SearchesController < ApplicationController

  def show
    search = params[:query].present? ? params[:query] : nil
    @pagy, @products = pagy_searchkick(Product.pagy_search(
      search,
      fields: ["name^10", "barcode^8", "category^6"],
      track: {user_id: user_signed_in? ? current_user.id : nil, source: "web search"},
      suggest: true,
      match: :text_middle,
    ))
  end

end
