class Candidate < ActiveRecord::Base

  has_many :candidate_elections
  has_many :elections, through: :candidate_elections

  belongs_to :organisation

  has_many :votes

  default_scope { where(deleted: false) }
  
end
