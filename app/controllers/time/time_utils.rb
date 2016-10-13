class TimeUtils

  def getUserTimebyDateRange user, start_date, end_date
    i=0
    row = {'entid':user.email}
    (start_date..end_date).each do |d|
      somma = Time::TimeReport.where(:user => user).where(:repdate => d).sum(:hours)
      row[i.to_s]=somma
      i = i+1
    end
    row
  end



end