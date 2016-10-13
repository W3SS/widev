class AddReasonToReport < ActiveRecord::Migration
  def change
    add_reference :time_time_reports , :time_reason, index: true

  end
end
