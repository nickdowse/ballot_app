class CandidatesController < ApplicationController
  before_action :set_election
  before_action :set_candidate, only: [:show, :edit, :update, :destroy, :remove_candidate]

  respond_to :html

  def index
    @candidates = @election.candidates.all.order("created_at DESC")
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

  def bulk_add
    @candidates = (current_organisation.candidates.all.order("created_at DESC") - @election.candidates)
  end

  def add_candidates_to_election
    @election.add_candidates(params[:candidates])
    redirect_to organisation_election_candidates_path(current_organisation, @election)
  end

  def remove_candidate
    @election.remove_candidate(@candidate)
    redirect_to organisation_election_candidates_path(current_organisation, @election)
  end

  def create
    if params["organisation_id"].to_i != current_organisation.id
      flash[:error] = "That's not allowed!"
      redirect_to :back and return
    end
    candidate_params[:organisation_id] = current_organisation.id
    @election.candidates << Candidate.new(candidate_params)
    @election.reload
    @candidate = @election.candidates.last
    flash[:notice] = 'Candidate was successfully created.' if @candidate.present? # What if election already has candidates and and the candidate is not created successfully
    redirect_to organisation_election_candidates_path(current_organisation, @election)
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
      params.require(:candidate).permit(:name, :organisation_id, :description, :avatar)
    end
end
