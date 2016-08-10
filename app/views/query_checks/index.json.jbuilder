json.array!(@query_checks) do |query_check|
  json.extract! query_check, :id, :title, :rpt_interval, :is_started, :is_paused, :statement, :num_exec, :last_exec_dt
  json.url query_check_url(query_check, format: :json)
end
