class ChangeDateFormatInMyTable < ActiveRecord::Migration
  def change
    change_column :query_checks, :last_exec_dt, :datetime
  end
end
