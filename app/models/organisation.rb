class Organisation < ActiveRecord::Base
  has_many :organisation_users
  has_many :users, source: :user, through: :organisation_users
  has_many :admins, -> { where(role: 'admin').uniq }, source: :user, through: :organisation_users
  has_many :allowed_emails
  has_many :elections
  has_many :candidates
  has_many :votes

  default_scope { where(deleted: false) }

  def is_admin?(user)
    self.admins.include?(user)
  end

  def add_admin(user)
    add_user(user, "admin")
  end

  def add_user(user, role = "user")
    OrganisationUser.create({user_id: user.id, organisation_id: self.id, role: role})
  end

  def destroy
    raise "Destroy???"
  end

end
