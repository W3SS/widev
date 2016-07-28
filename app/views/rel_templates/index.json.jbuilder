json.array!(@rel_templates) do |rel_template|
  json.extract! rel_template, :id, :name
  json.url rel_template_url(rel_template, format: :json)
end
