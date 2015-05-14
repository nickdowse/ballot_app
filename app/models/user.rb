class User < ActiveRecord::Base
  enum role: [:user, :admin]
  after_initialize :set_default_role, :if => :new_record?
  validate :allowed_email, :on => :create
  belongs_to :organisation

  def set_default_role
    self.role ||= :user
  end

  def allowed_email
    if self.organisation.allowed_emails.pluck(:email).include?(self.email)
      return true
    else
      errors.add(:email, "Sorry, that is not an approved email address. Please contact your admin #{self.organisation.admins.first.email}")
    end
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
