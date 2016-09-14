class CreateRtcInfos < ActiveRecord::Migration
  def change
    create_table :rtc_infos do |t|
      t.string :username
      t.string :password
      t.belongs_to :users, index: true
      t.timestamps null: false
    end
  end
end
