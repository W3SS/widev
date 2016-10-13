class Time::MyReportController < ApplicationController
  def calendar

    @reasons = Time::Reason.all
    @reports = Time::TimeReport.where(:user => current_user)

  end

  def index
  end

  def view
  end
end
