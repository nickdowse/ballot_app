class CandidateElection < ActiveRecord::Base
  # relations
  belongs_to :candidate
  belongs_to :election
  validates_presence_of :candidate
  validates_presence_of :election

  validates_uniqueness_of :candidate_id, :scope => :election_id
end
