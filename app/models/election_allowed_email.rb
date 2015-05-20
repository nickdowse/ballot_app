class ElectionAllowedEmail < ActiveRecord::Base
  belongs_to :election

  before_create :validate_included_in_org

  def validate_included_in_org
    if self.organisation.allowed_emails.pluck(:email).include?(self.email)
      return true
    else
      self.organisation.allowed_emails.create({email: self.email})
    end
  end

end
