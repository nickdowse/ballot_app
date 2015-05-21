json.array!(@votes) do |vote|
  json.extract! vote, :id, :value, :organisation_id, :election_id, :user_id, :date_voted, :history
  json.url organisation_eletion_vote_url(current_organisation, @election, vote, format: :json)
end
