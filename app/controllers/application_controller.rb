class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_organisation
    org = get_org_from_params
    if org.present?
      @organisation = org
      return @organisation
    else
      return nil
    end
  end
  helper_method :current_organisation # Make this method visible to views as well


  protected
    def get_org_from_params
      id = params[controller_name == 'organisations' ? :id : :organisation_id]
      if id.present?
        Organisation.find(id)
      else
        nil
      end
    end
end
