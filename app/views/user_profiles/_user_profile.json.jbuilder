json.extract! user_profile, :id, :email, :deployed, :team, :sap, :created_at, :updated_at,:ramp_skill,:ramp_skill_id
json.url user_profile_url(user_profile, format: :json)