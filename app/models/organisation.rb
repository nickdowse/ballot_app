class Organisation < ActiveRecord::Base
  has_many :users
  has_many :allowed_emails
  has_many :elections
  has_many :candidates
  has_many :votes

  def admins
    self.users.where(role: 1)
  end

  def is_admin?(user)
    self.admins.include?(user)
  end

end
