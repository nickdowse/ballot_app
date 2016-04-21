class VotesController < ApplicationController
  before_action :set_election
  before_action :set_vote, only: [:show, :edit, :update, :destroy]

  def index
    @votes = @election.votes.all
  end

  def new
    @vote = Vote.new
  end

  def edit
  end

  def create
    @vote = Vote.new(vote_params)
    @vote.organisation_id = current_organisation.id
    @vote.election_id = @election.id
    @vote.user_id = current_organisation.users.last
    @vote.value = 1
    if @vote.save
      flash[:notice] = "Your vote has been recorded"
    else
      flash[:error] = "Sorry, your vote could not be saved."
    end
    respond_with(current_organisation, @election)
  end

  def update
    if @vote.update_attributes(vote_params)
      respond_to do |format|
        format.json { render :text => "Successfully Done!" }
      end
    else
      respond_to do |format|
        format.json { render :text => "Failure!" }
      end
    end
  end

  private

    def set_election
      @election = current_organisation.elections.find(params[:election_id])
    end

    def set_vote
      @vote = @election.votes.find(params[:id])
    end

    def vote_params
      params.permit(:id, :value, :organisation_id, :election_id, :user_id, :history, :candidate_id)
    end
end
