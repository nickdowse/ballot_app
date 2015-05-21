class Vote < ActiveRecord::Base

  belongs_to :election
  belongs_to :organisation
  belongs_to :user
  belongs_to :candidate
end
