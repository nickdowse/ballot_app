class ElectionAllowedEmailsController < ApplicationController
  before_action :set_election
  before_action :set_election_allowed_email, only: [:show, :edit, :update, :destroy]
  respond_to :html

  def index
    @election_allowed_emails = @election.election_allowed_emails
    @election_allowed_email = ElectionAllowedEmail.new
    respond_with(@election_allowed_emails)
  end

  def show
    respond_with(current_organisation, @election, @election_allowed_email)
  end

  def new
    @election_allowed_email = ElectionAllowedEmail.new
    respond_with(current_organisation, @election, @election_allowed_email)
  end

  def edit
    election_allowed_email = @election_allowed_email
  end

  def create
    if params["election_allowed_email"]["organisation_id"].to_i != current_organisation.id
      flash[:error] = "That's not allowed!"
      redirect_to :back and return
    end

    if @election.election_allowed_emails.pluck(:email).include?(params["election_allowed_email"]["email"])
      flash[:error] = "That user already has access to this election."
      redirect_to :back and return
    end
    @election_allowed_email = @election.election_allowed_emails.new(election_allowed_email_params)
    @election_allowed_email.created_by = current_user.id
    @election_allowed_email.organisation_id = @election.organisation.id
    @election_allowed_email.save
    redirect_to organisation_election_election_allowed_emails_path(current_organisation, @election)
  end

  def update
    @election_allowed_email.update(election_allowed_email_params)
    redirect_to organisation_election_election_allowed_emails_path(current_organisation, @election)
  end

  def destroy
    @election_allowed_email.update_attribute(:deleted, true)
    redirect_to organisation_election_election_allowed_emails_path(current_organisation, @election)
  end

  private

    def set_election
      redirect_to :back unless current_organisation.is_admin?(current_user)
      @election = current_organisation.elections.find(params[:election_id])
    end

    def set_election_allowed_email
      @election_allowed_email = @election.election_allowed_emails.find(params[:id])
    end

    def election_allowed_email_params
      params.require(:election_allowed_email).permit(:email, :created_at, :election_id, :organisation_id)
    end
end
