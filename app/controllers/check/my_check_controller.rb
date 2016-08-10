class Check::MyCheckController < ApplicationController
  def start
    id = params[:check_id];
    check = QueryCheck.find(id)
    check.is_started=true
    check.save!
    Delayed::Job.where(queue: check.id.to_s ).destroy_all

    Delayed::Job.enqueue(check, queue: check.id.to_s, run_at: 2.seconds.from_now)
    redirect_to :back
    
  end

  def stop
    id = params[:check_id];
    check = QueryCheck.find(id)
    check.is_started=false
    check.save!
    
    redirect_to :back
  end

  def pause
    id = params[:check_id];
    check = QueryCheck.find(id)
    check.is_paused= check.is_paused ? false : true
    check.save!
    
    redirect_to :back


  end
  
  
  def viewjob
   @jobs = Delayed::Job.all
  end
  
  
  def viewresults
    
     id = params[:check_id];
     check = QueryCheck.find(id)
     
     @check_results = check.check_results.order(created_at: :desc).limit(200)
      
  end
  
end
