class User < ActiveRecord::Base
  enum role: [:user, :admin]
  has_many :organisation_users
  has_many :organisations, through: :organisation_users
  has_many :votes
  after_create :create_organisation
  # after_create :send_confirmation

  attr_accessor :role

  def create_organisation
    return if self.organisations.length > 0
    o = Organisation.create({name: self.email})
    o.add_admin(self)
  end

  # def send_confirmation
  #   self.confirmation_code = Digest::SHA1.hexdigest self.email
  #   save!
  # end

  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
end
