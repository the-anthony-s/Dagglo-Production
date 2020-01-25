module SellersHelper

  def onboarding_step_icon(step_completed)
    color = step_completed ? "text-success" : "text-secondary"
    content_tag :i, nil, class: ["fal", "fa-check-square", color]
  end

end
