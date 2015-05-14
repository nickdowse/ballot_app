class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?

  def current_organisation
    if user_signed_in?
      return @organisation if @organisation.present?
      @organisation = current_user.organisation
      return @organisation
    else
      @organisation = Organisation.find(params[controller_name == 'organisations' ? :id : :organisation_id])
      return @organisation
    end
  end
  helper_method :current_organisation # Make this method visible to views as well


  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) << :name
      devise_parameter_sanitizer.for(:sign_up) << :organisation_id
    end
end
