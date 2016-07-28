json.array!(@item_per_installations) do |item_per_installation|
  json.extract! item_per_installation, :id, :rel_template_item, :start_time, :end_time, :installation, :is_done, :is_started, :is_error, :note
  json.url item_per_installation_url(item_per_installation, format: :json)
end
