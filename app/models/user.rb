class User < ActiveRecord::Base
  enum role: [:user, :admin]
  has_many :organisation_users
  has_many :organisations, through: :organisation_users
  has_many :votes
  after_create :create_organisation

  attr_accessor :role

  def create_organisation
    return if self.organisations.length > 0
    o = Organisation.create({name: self.email})
    o.add_admin(self)
  end
end
