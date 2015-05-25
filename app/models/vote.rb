class Vote < ActiveRecord::Base

  belongs_to :election
  belongs_to :organisation
  belongs_to :user
  belongs_to :candidate

  validates :user_id, presence: true
  validates :election_id, presence: true
  validates :organisation_id, presence: true
  validates :candidate_id, presence: true

  validate :validate_uniq_scope, on: :create

  def validate_uniq_scope
    if self.election.votes.where(user_id: self.user_id).count == 0
      return true
    else
      errors.add(:user_id, "Sorry, you cannot vote more than once in this election.")
    end
  end
end
