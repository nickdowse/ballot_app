class ElectionsController < ApplicationController
  before_action :set_election, only: [:show, :edit, :update, :destroy]
  before_action :find_elections

  respond_to :html

  def index
    respond_with(@elections)
  end

  def show
    respond_with(@election)
  end

  def new
    @election = Election.new
    respond_with(@election)
  end

  def edit
  end

  def create
    @election = current_user.organisation.elections.new(election_params)
    flash[:notice] = 'Election was successfully created.' if @election.save
    respond_with(@election)
  end

  def update
    flash[:notice] = 'Election was successfully updated.' if @election.update(election_params)
    respond_with(@election)
  end

  def destroy
    @election.destroy
    respond_with(@election)
  end

  private

    def set_election
      @election = current_user.organisation.elections.find(params[:id])
    end

    def find_elections
      @elections = current_user.organisation.elections
    end

    def election_params
      params.require(:election).permit(:title, :created_at, :created_by)
    end
end
