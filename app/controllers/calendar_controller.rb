class CalendarController < ApplicationController
  def index
    
    @releases = Release.all
    @types = Reltype.all
    @systems = System.all
  end
end
