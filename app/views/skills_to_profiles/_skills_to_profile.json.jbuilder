json.extract! skills_to_profile, :id, :proficency, :note, :add1, :add2, :created_at, :updated_at,:skill_id,:user_profile_id
json.url skills_to_profile_url(skills_to_profile, format: :json)