json.array!(@check_results) do |check_result|
  json.extract! check_result, :id, :value, :query_check_id
  json.url check_result_url(check_result, format: :json)
end
