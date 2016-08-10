class AddEnvironmentToQueryCheck < ActiveRecord::Migration
  def change
      add_column :query_checks , :database_id , :integer
  end
end
