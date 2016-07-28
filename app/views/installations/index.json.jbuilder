json.array!(@installations) do |installation|
  json.extract! installation, :id, :release
  json.url installation_url(installation, format: :json)
end
