json.array!(@releases) do |release|
  json.extract! release, :id, :rel, :note, :outcome, :date, :completed
  json.url release_url(release, format: :json)
end
