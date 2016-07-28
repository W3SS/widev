json.installation do
    json.extract! @installation, :id, :release, :created_at, :updated_at, :is_done ,:is_started

json.items do
   json.array!(@installation.item_per_installation) do |i|
          json.rel_template_item do
             json.name i.rel_template_item.name
          end
          json.id i.id
          json.start_time i.start_time
          json.end_time i.end_time
          json.note 
          json.is_error i.is_error
          json.is_done i.is_done
          json.is_started i.is_started
          json.created_at i.created_at
          json.updated_at i.updated_at
    end
end
end