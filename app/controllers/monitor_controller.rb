class MonitorController < ApplicationController
  before_action :authenticate_user!
    def index
         @activities = PublicActivity::Activity.where(trackable_type:'Release').limit(100).order(created_at: :desc)
    end
end
