class ElectionsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_election, only: [:show, :edit, :update, :destroy, :results, :candidates]
  before_action :find_elections, only: [:index]

  respond_to :html

  def index
  end

  def show
    @vote = @election.votes.where(user_id: current_user.id).first
  end

  def new
    @election = Election.new
  end

  def edit
  end

  def create
    if current_organisation.elections.create!(election_params)
      flash[:notice] = 'Election was successfully created.'
      redirect_to organisation_elections_path(current_organisation) and return
    else
      flash[:error] = 'Election could not be created.'
      redirect_to :back and return
    end
  end

  def update
    if @election.update(election_params)
      flash[:notice] = 'Election was successfully updated.'
    else
      flash[:error] = 'Election could not be updated.'
    end
    redirect_to edit_organisation_election_path(current_organisation, @election)
  end

  def destroy
    @election.destroy
    redirect_to organisation_elections_path(current_organisation)
  end

  def results
    redirect_to :back unless current_organisation.is_admin?(current_user)
    results = []
    @election.candidates.each_with_index do |candidate, index|
      results[index] = (candidate.votes & @election.votes).count
    end
    @winning_vote_count = results.max
    @leader = @election.candidates[results.index(@winning_vote_count)]
  end

  def candidates
    @candidates = @election.candidates
  end


  private

    def set_election
      @election = current_organisation.elections.find(params[:id])
      redirect_to :back if @election.end_date < Time.now && !current_organisation.is_admin?(current_user)
    end

    def find_elections
      @elections = current_organisation.elections.order("created_at DESC")
    end

    def election_params
      params.require(:election).permit(:title, :created_at, :created_by, :description, :end_date)
    end
end
