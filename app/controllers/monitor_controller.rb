class MonitorController < ApplicationController
    def index
         @activities = PublicActivity::Activity.all.limit(100).order(created_at: :desc)
    end
end
