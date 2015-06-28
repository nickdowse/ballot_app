class User < ActiveRecord::Base
  enum role: [:user, :admin]
  after_initialize :set_default_role, :if => :new_record?
  validate :allowed_email, :on => :create
  has_many :organisation_users
  has_many :organisations, through: :organisation_users
  has_many :votes
  before_create :create_organisation
  after_create :send_confirmation

  def set_default_role
    self.role ||= :user
  end

  def allowed_email
    return if self.organisations.length == 0
    if self.organisation.allowed_emails.pluck(:email).include?(self.email)
      return true
    else
      errors.add(:email, "Sorry, that is not an approved email address. Please contact your admin #{self.organisation.admins.first.email}")
    end
  end

  def create_organisation
    return if self.organisations.length > 0
    o = Organisation.create({name: self.email})
    self.organisation_id = o.id
    self.role = 1
  end

  def send_confirmation
    self.confirmation_code = Digest::SHA1.hexdigest self.email
    save!
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
end
