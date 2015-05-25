class Organisation < ActiveRecord::Base
  has_many :organisation_users
  has_many :users, source: :user, through: :organisation_users
  has_many :admins, -> { where(role: 'admin').uniq }, source: :user, through: :organisation_users
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
