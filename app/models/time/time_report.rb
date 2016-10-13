class Time::TimeReport < ActiveRecord::Base
  self.table_name = "time_time_reports"
  belongs_to :user
  belongs_to :time_reason, :class_name => 'Time::Reason'

  def start_time
    self.repdate
  end

  def as_json(options={})
    super(:include => :time_reason)
  end
end
