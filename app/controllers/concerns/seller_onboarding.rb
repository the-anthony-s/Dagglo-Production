module SellerOnboarding

  extend ActiveSupport::Concern


  def should_see_onboarding?
    !onboarding_completed_at? || onboarding_completed_at > 1.day.ago
  end


  # Use to display or hide onboarding board
  def onboarding_percent
    return 100 if onboarding_completed_at?

    steps = [:has_business_info?, :has_product?, :has_location?]
    complete = steps.select { |step| send(step) }
    percent = complete.length / steps.length.to_f * 100
    update(onboarding_completed_at: Time.current) if percent == 100
    percent
  end

  
  def has_business_info?
    about? || founding_date? || image_data? || cover_data? || business_number?
  end


  def has_product?
    seller_products.present?
  end


  def has_location?
    seller_locations.present?
  end


  def has_plan?
    # Seller chose a subscription plan
  end

end