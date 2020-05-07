class ApplicationController < ActionController::Base
  include SearchFallback
  include PublicActivity::StoreController
  include Pagy::Backend

  protect_from_forgery with: :exception

  # after_action :track_action

  before_action :store_user_location!, if: :storable_location?
  before_action :set_time_zone
  # before_action :set_locale



  # Default Time Zone detector
  # Works with jstz -> webpack -> timezone.js
  def set_time_zone
    if user_signed_in? && current_user.time_zone.present?
      Time.zone = current_user.time_zone
    else
      # Time.zone = cookies[:timezone]
      browser_time_zone
    end
  end

  def browser_time_zone
    browser_tz = ActiveSupport::TimeZone.find_tzinfo(cookies[:timezone])
    ActiveSupport::TimeZone.all.find { |zone| zone.tzinfo == browser_tz } || Time.zone
  rescue TZInfo::UnknownTimezone, TZInfo::InvalidTimezoneIdentifier
    Time.zone
  end
  helper_method :browser_time_zone



  # Public_event configurations
  def user_seller_account
    @user_account ||= current_user.s_account
  end
  helper_method :user_account



  private

    # def set_locale
    #   I18n.locale = params[:locale] || I18n.default_locale
    #   # current_user.locale
    #   # request.env["HTTP_ACCEPT_LANGUAGE"]
    # end

    # def default_url_options(options = {})
    #   { locale: I18n.locale }.merge options
    # end



    # Return user back after login
    def storable_location?
      request.get? && is_navigational_format? && !devise_controller? && !request.xhr?
    end

    def store_user_location!
      store_location_for(:user, request.fullpath)
    end

    def after_sign_in_path_for(resource_or_scope)
      stored_location_for(resource_or_scope) || super
    end

    def after_sign_out_path_for(resource_or_scope)
      request.referrer || super
    end



  protected

    # Track current_user's actions
    def track_action
      ahoy.track "Viewed #{controller_name}##{action_name}", request.filtered_parameters
    end
end
