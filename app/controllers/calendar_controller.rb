class CalendarController < ApplicationController
  def index
    
    @releases = Release.all
  end
end
