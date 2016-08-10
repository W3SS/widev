class QueryCheck < ActiveRecord::Base
    
    has_many :check_results
    
    def perform
        if !is_paused && is_started
           executecheck
        end
        
        if is_started
            rescheduleme
        end
    end
    
    def executecheck
        result = CheckResult.new
        result.value = rand(5..1030).to_s
        result.query_check_id = self.id
        result.save!
        self.num_exec = self.num_exec+1
        self.last_exec_dt = Time.now
        self.save!
    end

    
    def display_name
        return "Job-#{title} "
    end 
    
    
    def rescheduleme
        Delayed::Job.enqueue(self, queue: self.id.to_s, run_at: self.rpt_interval.seconds.from_now)
    end
end
