class AddDetailToWebservice < ActiveRecord::Migration
  def change
    add_column :webservices, :comments, :text
    add_column :webservices, :involvedflow, :text
    add_column :webservices, :workflow, :text
  end
end
