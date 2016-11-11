class Time::TimeUtils



  def self.getProfileTimeForDateAndReason (profile , date, reason, enableFcast)

    if(profile.user != nil)
      user = profile.user
      hours = 0
      sum_hour  = Time::TimeReport.where(:time_reason_id => reason.id)
                                 .where(:user_id=> user.id)
                                 .where(:repdate => date)
                                 .select('sum(time_time_reports.hours) as somma ,count(*) as numero').first
    else
      sum_hour  = Time::TimeReport.where(:time_reason_id => reason.id)
                      .where(:user_id=> "99999999")
                      .where(:repdate => date)
                      .select('sum(time_time_reports.hours) as somma ,count(*) as numero').first

    end


    sum_hour.somma == nil ? hours = 0: hours=(sum_hour.somma.to_f)

    if enableFcast == true && sum_hour.numero.to_i == 0
      hours = "?" + self.getFcast(date,reason).to_s
    end

    hours

  end

  def self.getColumnsDef(start_dt ,end_dt)

    columnDefs = [{headerName: "Email", field: "email", width: 240},
                  {headerName: "Sap", field: "sap", width: 90},
                  {headerName: "Reason", field: "reason", width: 80}]

    (start_dt..end_dt).each() do |day|
      columnDefs <<  {headerName: day.strftime('%d'), field: day.strftime('%d-%m'), width: 45}
    end

    columnDefs <<  {headerName: 'Total', field: 'total', width: 45}
    columnDefs <<  {headerName: 'Avg', field: 'avg', width: 45}

  columnDefs

  end

  def self.getFcast(date, reason)

    if(Date.today > date)
      return 0
    end


    if reason != nil
      fcast = reason.fcast_value
      if(date.saturday? || date.sunday?)
        fcast=0
      end

      #Check per festività
      fest = Time::Festivitum.where(festdate: date).first
      if fest != nil  && reason.fcast_value > 0
        fcast=fest.forecast_val
      end

    else

      fcast=0

    end

    fcast
  end


end