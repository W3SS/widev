class CreateUserProfiles < ActiveRecord::Migration
  def change
    create_table :user_profiles do |t|
      t.boolean :deployed
      t.string :team
      t.string :sap
      t.string :email , :unique=>true , index: true
      t.timestamps null: false
    end
  end
end
