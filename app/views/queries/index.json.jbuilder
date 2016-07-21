json.array!(@queries) do |query|
  json.extract! query, :id, :title, :statment
  json.url query_url(query, format: :json)
end
