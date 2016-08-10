class AddTypeToQueryCheck < ActiveRecord::Migration
  def change
    add_column :query_checks , :is_complex , :boolean
  end
end
