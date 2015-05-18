class Election < ActiveRecord::Base
  belongs_to :organisation
  has_many :election_allowed_emails

  # Active record hooks
  before_create :set_defaults

  def set_defaults
    self.created_at = Time.now
  end

end
