json.array!(@links) do |link|
  json.extract! link, :id, :url, :description, :is_available
  json.url link_url(link, format: :json)
end
