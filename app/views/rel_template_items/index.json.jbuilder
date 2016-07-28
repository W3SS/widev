json.array!(@rel_template_items) do |rel_template_item|
  json.extract! rel_template_item, :id, :name, :description, :note
  json.url rel_template_item_url(rel_template_item, format: :json)
end
