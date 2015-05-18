class AllowedEmailsController < ApplicationController
  before_action :set_allowed_email, only: [:show, :edit, :update, :destroy]
  respond_to :html

  def index
    @allowed_emails = current_organisation.allowed_emails.all
    respond_with(@allowed_emails)
  end

  def create
    @allowed_email = AllowedEmail.new(allowed_email_params)
    flash[:notice] = 'Email was successfully created.' if @allowed_email.save
    redirect_to edit_organisation_path(current_organisation)
  end

  def update
    flash[:notice] = 'allowed_email was successfully updated.' if @allowed_email.update(allowed_email_params)
    respond_with(@allowed_email)
  end

  def destroy
    @allowed_email.destroy
    respond_with(@allowed_email)
  end

  private

    def set_allowed_email
      @allowed_email = AllowedEmail.find(params[:id])
    end

    def allowed_email_params
      pp params
      params.require(:allowed_email).permit(:email, :organisation_id)
    end
end
