class MyQueryController < ApplicationController
    before_action :authenticate_user!

  
  def index
    @queries = Query.all
  end

  def show
    @query  = Query.find(params[:id])

  end
end
