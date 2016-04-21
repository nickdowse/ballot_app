class CandidatesController < ApplicationController

  before_action :find_election, only: [:index]
  before_action :set_candidate, only: [:show, :edit, :update, :destroy, :remove_candidate]
  before_action :validate_organisation, only: [:show, :edit, :update, :destroy, :remove_candidate]


  def index
    if @election.present?
      @candidates = @election.candidates.order("created_at DESC")
    else
      @candidates = current_organisation.candidates.all.order("created_at DESC")
    end
  end

  def show
  end

  def new
    @candidate = current_organisation.candidates.new
  end

  def edit
  end

  def create
    if current_organisation.candidates.create(candidate_params)
      flash[:notice] = 'Candidate was successfully created.'
    else
      flash[:error] = 'Candidate could not be created.'
    end
    redirect_to organisation_candidates_path(current_organisation)
  end

  def update
    if @candidate.update(candidate_params)
      flash[:notice] = 'Candidate was successfully updated.'
    else
      flash[:error] = 'Candidate was successfully updated.'
    end
    redirect_to edit_organisation_candidate_path(current_organisation, @candidate)
  end

  def destroy
    @candidate.update_attribute(:deleted, true)
    redirect_to edit_organisation_candidates_path(current_organisation, @election.candidates)
  end

  private

    def validate_organisation
      if params[:organisation_id].to_i != current_organisation.id
        flash[:error] = "That's not a part of this organisation!"
        redirect_to :back and return
      end
    end

    def find_election
      if params[:election_id].present?
        @election = current_organisation.elections.where(id: params[:election_id]).first
      end
    end

    def set_candidate
      @candidate = current_organisation.candidates.find(params[:id])
    end

    def candidate_params
      params.require(:candidate).permit(:name, :organisation_id, :description, :avatar, election_ids: [])
    end
end
