class OrganisationsController < ApplicationController

  def index
    @organisations = Organisation.all
  end

  def show
  end

  def new
    @organisation = Organisation.new
  end

  def edit
  end

  def create
    @organisation = Organisation.new(organisation_params)
    flash[:notice] = 'Organisation was successfully created.' if @organisation.save
  end

  def update
    if current_organisation.update(organisation_params)
      flash[:notice] = 'Organisation was successfully updated.'
    else
      flash[:error] = 'Organisation could not be updated.'
    end
    redirect_to organisation_path(current_organisation)
  end

  def users
    @users = current_organisation.users
  end

  def destroy
    current_organisation.destroy
  end

  private

    def organisation_params
      params.require(:organisation).permit(:name)
    end
end
