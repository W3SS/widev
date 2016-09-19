class AddEnvironmentToLink < ActiveRecord::Migration
  def change
    add_reference :links, :environment, index: true
  end
end
