module SellersHelper


  def onboarding_step_icon(step_completed)
    color = step_completed ? "onboarding_step_completed" : nil
    content_tag :i, nil, class: ["fad", "fa-check-circle", color]
  end


  def static_map(model, height, width, zoom)
    if model.longitude.present? && model.latitude.present?
      "http://maps.googleapis.com/maps/api/staticmap?center=#{model.latitude},#{model.longitude}&markers=#{model.latitude},#{model.longitude}&zoom=#{zoom}&size=#{height}x#{width}&key=AIzaSyAfioIw_NiEIej4B-jmqT06gOTZv3R8WY8"
    else
      ActionController::Base.helpers.asset_path("defaults/" + ["default.png"].compact.join('_'))
    end
  end


  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, {:sort => column, :direction => direction}, {:class => css_class}
  end

  
end
