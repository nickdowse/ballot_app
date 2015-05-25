class VotesController < ApplicationController
  before_action :set_election
  before_action :set_vote, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @votes = @election.votes.all
    respond_with(@votes)
  end

  def new
    @vote = Vote.new
    respond_with(@vote)
  end

  def edit
  end

  def create
    @vote = Vote.new(vote_params)
    @vote.organisation_id = current_organisation.id
    @vote.election_id = @election.id
    @vote.user_id = current_user.id
    @vote.value = 1
    if @vote.save
      flash[:notice] = "Your vote has been recorded"
    else
      flash[:error] = "Sorry, your vote was not saved."
    end
    respond_with(current_organisation, @election)
  end

  def update
    if @vote.update(vote_params)
      flash[:notice] = "Your vote has been updated"
    else
      flash[:error] = "Sorry, your vote was not updated. Please contact an admin: #{current_user.admins.first.email}"
    end
    respond_with(current_organisation, @election)
  end

  private

    def set_election
      @election = current_organisation.elections.find(params[:election_id])
    end

    def set_vote
      @vote = @election.votes.find(params[:id])
    end

    def vote_params
      params.require(:vote).permit(:value, :organisation_id, :election_id, :user_id, :history, :candidate_id)
    end
end
