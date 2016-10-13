class Time::AdminController < ApplicationController
  def index
    start_date = Date.parse(params[:sdate])
    end_date = Date.parse(params[:edate]) #start_date + (params[:days].to_i).days

    @start_date = start_date
    @end_date = end_date
    @explode = params['explode']

    @users = User.all
    @reports =[]
    @columns = []
    @rows=[]
    @columns << {key: 'entid',
                 name: 'Ent ID',
                 width: 250,filterable: true}
    if params[:explode] =="1"
      @columns << {key: 'reason',
                   name: 'Reason',
                   width: 100,filterable: true}
    end

    i=0
    (start_date..end_date).each do |d|

      @columns << {key: i ,
                   name:d.strftime("%d") ,
                   width: 40}

      i = i+1
    end
    @columns << {key: 'tot', name: 'Tot', width: 50}
    @columns << {key: 'totfcast', name: 'Fcast', width: 50}
    @columns << {key: 'avg', name: 'Avg', width: 50}
    @columns << {key: 'avg15', name: 'A15', width: 50}
    @columns << {key: 'avg30', name: 'A30', width: 50}

    @users.each do |user|
      if params[:explode] =="1"
        tr  = Time::TimeReport.where(:user => user).where("repdate > ?", start_date).where("repdate < ?", end_date).select("distinct(time_reason_id) as reason_id")
        tr.each() do |r|
           @rows << getUserTimebyDateRangeWithNAbyReason(user,start_date,end_date,r.reason_id)
        end
      else
        @rows << getUserTimebyDateRangeWithNA(user,start_date,end_date)
      end

    end

  end

  def getUserTimebyDateRangeWithNA user, start_date, end_date
    i=0
    tot=0
    tot_fcast=0
    avg_i=0
    row = {'entid':user.email}
    (start_date..end_date).each do |d|

      result = Time::TimeReport.where(:user => user).where(:repdate => d).select('sum(hours) as somma, count(*) as submissions').first
      if result
        if result.submissions > 0
          row[i.to_s]=result.somma
          avg_i +=1
          tot += result.somma
          tot_fcast += result.somma
        else
          row[i.to_s]="-"
          tot_fcast += getFcast(d,nil)
        end
      else
        row[i.to_s]="-"
        tot_fcast += getFcast(d,nil)
      end
      i = i+1
    end
    if avg_i>0
      row['avg']=tot/avg_i
    else
      row['avg']=0
    end
    row['tot']=tot
    row['totfcast']=tot_fcast
    #Calcola avg 15gg before
    row['avg15']= Time::TimeReport.where(:user => user)
                      .where("repdate > ?", start_date - 15.days)
                      .where("repdate < ?", end_date - 15.days)
                      .sum(:hours)/(end_date - start_date).to_i

    #Calcola avg 30gg before

    row['avg30']= Time::TimeReport.where(:user => user)
                      .where("repdate > ?", start_date - 30.days)
                      .where("repdate < ?", end_date - 30.days)
                      .sum(:hours)/(end_date - start_date).to_i

    row
  end


  def getUserTimebyDateRangeWithNAbyReason user, start_date, end_date, reason
    i=0
    tot=0
    tot_fcast =0
    avg_i=0
    res= Time::Reason.find(reason)
    row = {'entid':user.email,'reason':res.name}
    (start_date..end_date).each do |d|

      result = Time::TimeReport.where(:user => user)
                    .where(:time_reason_id => reason)
                    .where(:repdate => d).select('sum(hours) as somma, count(*) as submissions').first
      if result
        if result.submissions > 0
          row[i.to_s]=result.somma
          avg_i +=1
          tot += result.somma
          tot_fcast += result.somma
        else
          row[i.to_s]="-"
          tot_fcast += getFcast(d,res)
        end
      else
        row[i.to_s]="-"
        tot_fcast += getFcast(d,res)
      end
      i = i+1
    end
    if avg_i>0
      row['avg']=tot/avg_i
    else
      row['avg']=0
    end


    row['tot']=tot
    row['totfcast']=tot_fcast
    #Calcola avg 15gg before
    row['avg15']= Time::TimeReport.where(:user => user)
                      .where(:time_reason_id => reason)
                      .where("repdate > ?", start_date - 15.days)
                      .where("repdate < ?", end_date - 15.days)
                      .sum(:hours)/(end_date - start_date).to_i

    #Calcola avg 30gg before

    row['avg30']= Time::TimeReport.where(:user => user)
                      .where(:time_reason_id => reason)
                      .where("repdate > ?", start_date - 30.days)
                      .where("repdate < ?", end_date - 30.days)
                      .sum(:hours)/(end_date - start_date).to_i


    row
  end

  def getFcast(date, reason)

    if reason != nil
      fcast = reason.fcast_value

      if(date.saturday? || date.sunday?)
        fcast=0
      end
    else
      fcast=0
    end

    fcast
  end

  def export

    start_date = Date.parse(params[:sdate])
    end_date = Date.parse(params[:edate]) #start_date + (params[:days].to_i).days
    @users = User.all
    @reports =[]
    @columns = []
    @rows=[]

      date = DateTime.now

      name = "Carichi-"+start_date.strftime("%Y%m%d")+"-"+ end_date.strftime("%Y%m%d") +".xlsx"
      path = "tmp/"+ name

      workbook = WriteXLSX.new(path)
      worksheets = Hash.new

      format = workbook.add_format # Add a format
      format.set_bold
      format.set_color('yellow')
      format.set_align('left')
      format.set_bg_color('blue')
      format2 = workbook.add_format # Add a format
      format2.set_align('left')
      format2.set_text_justlast

    worksheets[0] = workbook.add_worksheet('CARICHI')
    row=1

    @users.each do |user|
        if params[:explode] =="1"
          tr  = Time::TimeReport.where(:user => user).where("repdate > ?", start_date).where("repdate < ?", end_date).select("distinct(time_reason_id) as reason_id")
          tr.each() do |r|
            @rows << getUserTimebyDateRangeWithNAbyReason(user,start_date,end_date,r.reason_id)
          end
        else
          @rows << getUserTimebyDateRangeWithNA(user,start_date,end_date)
        end
        row = row +1
    end

    row=1

    @rows.each() do |r|
      col=0

      r.each() do |key, value|
        if is_number?(key)
          days = key.to_i
          worksheets[0].write(0,   col, (start_date + days.days).strftime('%d/%m'),format )
        else
          worksheets[0].write(0,   col, key,format )
        end
        worksheets[0].write(row,   col, value.to_s,format2 )
        col +=1
      end
      row= row +1
    end

    workbook.close

    send_file path, :type => "application/octet-stream", :filename => name, :stream => false, :disposition => 'attachment'
  end


  def is_number?(string)
    # `!!` converts parsed number to `true`
    !!Kernel.Float(string)
  rescue TypeError, ArgumentError
    false
  end


end
