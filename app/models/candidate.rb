class Candidate < ActiveRecord::Base

  has_many :candidate_elections
  has_many :elections, through: :candidate_elections

  belongs_to :organisation

  has_many :votes

  default_scope { where(deleted: false) }

  has_attached_file :avatar, styles: {
    thumb: '100x100>',
    square: '200x200#',
    medium: '300x300>'
  }

  # Validate the attached image is image/jpg, image/png, etc
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/  
end
