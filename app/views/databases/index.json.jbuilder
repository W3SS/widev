json.array!(@databases) do |database|
  json.extract! database, :id, :sid, :user, :pass
  json.url database_url(database, format: :json)
end
