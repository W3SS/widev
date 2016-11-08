class AddRampupSkillToUserProfile < ActiveRecord::Migration
  def change
    add_column :user_profiles , :ramp_skill_id , :integer
  end
end
