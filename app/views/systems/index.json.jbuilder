json.array!(@systems) do |system|
  json.extract! system, :id, :name, :color, :short
  json.url system_url(system, format: :json)
end
