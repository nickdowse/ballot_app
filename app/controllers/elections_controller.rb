class ElectionsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_election, only: [:show, :edit, :update, :destroy, :results]
  before_action :find_elections, only: [:index]

  respond_to :html

  def index
    respond_with(current_organisation, @elections)
  end

  def show
    @vote = @election.votes.where(user_id: current_user.id).first
    respond_with(current_organisation, @election)
  end

  def new
    @election = Election.new
    respond_with(current_organisation, @election)
  end

  def edit
  end

  def create
    @election = current_organisation.elections.new(election_params)
    flash[:notice] = 'Election was successfully created.' if @election.save
    respond_with(current_organisation, @election)
  end

  def update
    flash[:notice] = 'Election was successfully updated.' if @election.update(election_params)
    respond_with(current_organisation, @election)
  end

  def destroy
    @election.destroy
    respond_with(current_organisation, @election)
  end

  def results
    redirect_to :back unless current_organisation.is_admin?(current_user)
    @results = []
    @election.candidates.each_with_index do |c, i|
      @results[i] = (c.votes & @election.votes).count
    end
    @winner = @election.candidates[@results.index(@results.max)]
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
