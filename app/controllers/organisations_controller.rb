class OrganisationsController < ApplicationController
  before_action :set_organisation, only: [:show, :edit, :update, :destroy]

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
    if @organisation.update(organisation_params)
      flash[:notice] = 'Organisation was successfully updated.'
    else
      flash[:error] = 'Organisation could not be updated.'
    end
  end

  def users
    @users = current_organisation.users
  end

  def destroy
    @organisation.destroy
  end

  private
    def set_organisation
      @organisation = Organisation.find(params[:id])
    end

    def organisation_params
      params.require(:organisation).permit(:name)
    end
end
