class Election < ActiveRecord::Base
  belongs_to :organisation
  has_many :election_allowed_emails

  has_many :candidate_elections
  has_many :candidates, through: :candidate_elections

  has_many :votes

  scope :draft, -> { where(state: "draft") }
  scope :published, -> { where(state: "published") }
  scope :hidden, -> { where(state: "hidden") }
  scope :expired, -> { where("state = 'expired' or end_date < ?", Time.now) }
  scope :active, -> { where("state = 'published' or state = 'hidden'") }

  # Active record hooks
  before_create :set_defaults

  def set_defaults
    self.created_at = Time.now
  end

end
