class ElectionAllowedEmailsController < ApplicationController
  before_action :set_election
  before_action :set_election_allowed_email, only: [:show, :edit, :update, :destroy]
  respond_to :html

  def index
    @election_allowed_emails = ElectionAllowedEmail.all
    respond_with(@election_allowed_emails)
  end

  def show
    respond_with(@election_allowed_email)
  end

  def new
    @election_allowed_email = ElectionAllowedEmail.new
    respond_with(@election_allowed_email)
  end

  def edit
  end

  def create
    if params["election_allowed_email"]["organisation_id"].to_i != current_user.organisation.id
      flash[:error] = "That's not allowed!"
      redirect_to :back and return
    end
    @election_allowed_email = @election.election_allowed_emails.new(election_allowed_email_params)
    @election_allowed_email.created_by = current_user.id
    @election_allowed_email.save
    respond_with(@election, @election_allowed_email)
  end

  def update
    @election_allowed_email.update(election_allowed_email_params)
    respond_with(@election_allowed_email)
  end

  def destroy
    @election_allowed_email.destroy
    respond_with(@election_allowed_email)
  end

  private

    def set_election
      @election = current_user.organisation.elections.find(params[:election_id])
    end

    def set_election_allowed_email
      @election_allowed_email = @election.election_allowed_emails.find(params[:id])
    end

    def election_allowed_email_params
      params.require(:election_allowed_email).permit(:email, :created_at, :election_id, :organisation_id)
    end
end
