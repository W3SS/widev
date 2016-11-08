class CreateSkillsToProfiles < ActiveRecord::Migration
  def change
    create_table :skills_to_profiles do |t|
      t.integer :proficency
      t.string :note
      t.string :add1
      t.string :add2

      t.timestamps null: false
    end
  end
end
