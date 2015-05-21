class OrganisationsController < ApplicationController
  before_action :set_organisation, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @organisations = Organisation.all
    respond_with(@organisations)
  end

  def show
    respond_with(@organisation)
  end

  def new
    @organisation = Organisation.new
    respond_with(@organisation)
  end

  def edit
  end

  def create
    @organisation = Organisation.new(organisation_params)
    flash[:notice] = 'Organisation was successfully created.' if @organisation.save
    respond_with(@organisation)
  end

  def update
    flash[:notice] = 'Organisation was successfully updated.' if @organisation.update(organisation_params)
    respond_with(@organisation)
  end

  def destroy
    @organisation.destroy
    respond_with(@organisation)
  end

  private
    def set_organisation
      @organisation = Organisation.find(params[:id])
    end

    def organisation_params
      params.require(:organisation).permit(:name)
    end
end