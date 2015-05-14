class Organisation < ActiveRecord::Base
  has_many :users
  has_many :allowed_emails

  def admins
    self.users.where(role: 1)
  end
end
