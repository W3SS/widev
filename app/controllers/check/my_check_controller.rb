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

  def executeonce
    id = params[:check_id];
    check = QueryCheck.find(id)
    check.executecheck


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

  def resultdetail
      resultid = params[:result_id]
      @result = CheckResult.find(resultid)
      @last_result = CheckResult.where("created_at < ?", @result.created_at).where("query_check_id = ?",@result.query_check_id.to_s).order(created_at: :desc).first
      @tbl = JSON.parse(@result.value)
      @last_tbl = JSON.parse(@last_result.value)
  end
  
end
