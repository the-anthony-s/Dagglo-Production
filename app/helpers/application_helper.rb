module ApplicationHelper

  # Use for title content
  def title(page_title)
    content_for(:title) { page_title }
  end

end
