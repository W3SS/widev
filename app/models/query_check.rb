class QueryCheck < ActiveRecord::Base
    
    has_many :check_results
    belongs_to :database

    def perform
        if !is_paused && is_started
           executecheck
        end
        
        if is_started
            rescheduleme
        end
    end
    
    def executecheck

        result=""
        logger.info("Start Executing Check")
        oracle = OCI8.new(self.database.user, self.database.pass, self.database.sid)

        if self.statement.include? "DELETE"
            self.statement="SELECT 'DELETE NOT PERMITTED' from DUAL"
            self.save!
        end
        if self.statement.include? "UPDATE"
            self.statement="SELECT 'UPDATE NOT PERMITTED' from DUAL"
            self.save!
        end
        if self.statement.include? "TRUNCATE"
            self.statement="SELECT 'TRUNCATE NOT PERMITTED' from DUAL"
            self.save!
        end

        if self.statement.include? "DROP"
            self.statement="SELECT 'DROP NOT PERMITTED' from DUAL"
            self.save!
        end


        cursor = oracle.exec(self.statement)
        q_result = []

        while r = cursor.fetch_hash()
            q_result.push(r)
        end

        result = CheckResult.new
        result.value = q_result.to_json
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
