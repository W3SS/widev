json.array!(@rel_template_items) do |rel_template_item|
  json.extract! rel_template_item, :id, :name, :description, :note
end
