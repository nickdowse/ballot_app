json.array!(@candidates) do |candidate|
  json.extract! candidate, :id, :name, :organisation_id, :description
  json.url organisation_election_candidate_url(current_organisation, @election, candidate, format: :json)
end
