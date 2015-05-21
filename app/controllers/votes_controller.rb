class VotesController < ApplicationController
  before_action :set_election
  before_action :set_vote, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @votes = @election.votes.all
    respond_with(@votes)
  end

  def show
    respond_with(@vote)
  end

  def new
    @vote = Vote.new
    respond_with(@vote)
  end

  def edit
  end

  def create
    @vote = Vote.new(vote_params)
    @vote.save
    respond_with(@vote)
  end

  def update
    @vote.update(vote_params)
    respond_with(@vote)
  end

  def destroy
    @vote.destroy
    respond_with(@vote)
  end

  private

    def set_election
      @election = current_organisation.elections.find(params[:election_id])
    end

    def set_vote
      @vote = @election.find(params[:id])
    end

    def vote_params
      params.require(:vote).permit(:value, :organisation_id, :election_id, :user_id, :date_voted, :history)
    end
end
