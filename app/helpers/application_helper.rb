module ApplicationHelper

  # Use for title content
  def title(page_title)
    content_for(:title) { page_title }
  end



  # Formatted amount
  def formatted_amount(amount, options={})
    number_to_currency(amount.to_i / 100.0, options)
  end

end
