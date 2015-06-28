class CandidatesController < ApplicationController
  before_action :set_election
  before_action :set_candidate, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @candidates = @election.candidates.all
    respond_with(current_organisation, @election)
  end

  def show
    respond_with(current_organisation, @election, @candidate)
  end

  def new
    @candidate = @election.candidates.new
    respond_with(current_organisation, @election, @candidate)
  end

  def edit
  end

  def create
    if params["candidate"]["organisation_id"].to_i != current_organisation.id
      flash[:error] = "That's not allowed!"
      redirect_to :back and return
    end
    @election.candidates << Candidate.new(candidate_params)
    @election.reload
    @candidate = @election.candidates.last
    flash[:notice] = 'Candidate was successfully created.' if @candidate.present?
    respond_with(current_organisation, @election, @candidate)
  end

  def update
    flash[:notice] = 'Candidate was successfully updated.' if @candidate.update(candidate_params)
    respond_with(current_organisation, @election, @candidate)
  end

  def destroy
    @candidate.update_attribute(:deleted, true)
    redirect_to edit_organisation_election_candidates_path(current_organisation, @election, @election.candidates)
  end

  private

    def set_election
      @election = current_organisation.elections.find(params[:election_id])
    end

    def set_candidate
      @candidate = @election.candidates.find(params[:id])
    end

    def candidate_params
      params.require(:candidate).permit(:name, :organisation_id, :description)
    end
end
