json.array!(@elections) do |election|
  json.extract! election, :id, :title, :created_at, :created_by
  json.url election_url(election, format: :json)
end
