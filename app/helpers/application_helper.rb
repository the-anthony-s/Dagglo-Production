module ApplicationHelper
  include Pagy::Frontend

  # Shrine configuration
  def upload_server
    Rails.configuration.upload_server
  end



  # Use for title content
  def title(page_title)
    content_for(:title) { page_title }
  end



  # Formatted amount
  def formatted_amount(amount, options={})
    number_to_currency(amount.to_i / 100.0, options)
  end

end
