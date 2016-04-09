class CandidatesController < ApplicationController
  before_action :set_election
  before_action :set_candidate, only: [:show, :edit, :update, :destroy, :remove_candidate]
  before_action :validate_organisation, only: [:show, :edit, :update, :destroy, :remove_candidate]

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
    if @election.candidates.create(candidate_params)
      flash[:notice] = 'Candidate was successfully created.'
    else
      flash[:error] = 'Candidate could not be created.'
    end
    redirect_to organisation_election_candidates_path(current_organisation, @election)
  end

  def update
    if @candidate.update(candidate_params)
      flash[:notice] = 'Candidate was successfully updated.'
    else
      flash[:error] = 'Candidate was successfully updated.'
    end
    redirect_to edit_organisation_election_candidate_path(current_organisation, @election, @candidate)
  end

  def destroy
    @candidate.update_attribute(:deleted, true)
    redirect_to edit_organisation_election_candidates_path(current_organisation, @election, @election.candidates)
  end

  private

    def validate_organisation
      if params[:organisation_id].to_i != current_organisation.id
        flash[:error] = "That's not a part of this organisation!"
        redirect_to :back and return
      end
    end

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
