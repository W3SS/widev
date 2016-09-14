json.array!(@rtc_infos) do |rtc_info|
  json.extract! rtc_info, :id, :username, :password, :user_id
  json.url rtc_info_url(rtc_info, format: :json)
end
