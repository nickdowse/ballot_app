json.array!(@elections) do |election|
  json.extract! election, :id, :title, :created_at, :created_by
  json.url organisation_election_url(current_organisation, election, format: :json)
end
