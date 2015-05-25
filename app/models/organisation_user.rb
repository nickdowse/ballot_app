class OrganisationUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :organisation
  validates_presence_of :user
  validates_presence_of :organisation

  validates_uniqueness_of :user_id, :scope => :organisation_id
end
