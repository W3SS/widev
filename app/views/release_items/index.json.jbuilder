json.array!(@release_items) do |release_item|
  json.extract! release_item, :id, :name, :type, :scratchable, :remove
  json.url release_item_url(release_item, format: :json)
end
