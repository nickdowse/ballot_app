json.array!(@election, @election_allowed_emails) do |election_allowed_email|
  json.extract! election_allowed_email, :id, :email, :created_at, :election_id, :organisation_id
  json.url organisation_election_election_allowed_email_url(current_organisation, election_id: @election.id, id: election_allowed_email.id, format: :json)
end
