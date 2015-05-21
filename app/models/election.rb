class Election < ActiveRecord::Base
  belongs_to :organisation
  has_many :election_allowed_emails

  has_many :candidate_elections
  has_many :candidates, through: :candidate_elections

  has_many :votes

  # Active record hooks
  before_create :set_defaults

  def set_defaults
    self.created_at = Time.now
  end

end
