json.array!(@reltypes) do |reltype|
  json.extract! reltype, :id, :name, :color, :short
  json.url reltype_url(reltype, format: :json)
end
