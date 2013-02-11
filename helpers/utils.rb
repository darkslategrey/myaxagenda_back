

class Utils
  
  @@mylogger = Logger.new(STDOUT)

  def self.cal_to_class(cal_nbr)
    class_name = nil
    case cal_nbr.to_i
    when Calendar::REGIE_JOBDEPENDANCE, Calendar::ACTIONS_JOBDEPENDANCE
      @@mylogger.debug("jobdependance event")
      class_name = "EventJd"
    when Calendar::REGIE_JOBENFANCE, Calendar::ACTIONS_JOBENFANCE
      @@mylogger.debug("jobenfance event")
      class_name = "EventJe"
    else
      @@mylogger.debug("Calendar type not found <#{id}>")
    end

    return eval(class_name) if not class_name.nil?
    nil
  end

  def self.end_hour(event)
    hour_s = ''
    begin
      hour = event.fulldayevent ? 24 : DateTime.parse(event.datep2.to_s).hour
      if(hour < 10)
        hour_s = '0'+hour.to_s
      else
        hour_s = hour.to_s
      end
    rescue ArgumentError
      hour_s = '00'
    end
    hour_s
  end

  def self.end_minute(event)
    minute_s = ''
    begin
      minute = event.fulldayevent ? 0 : DateTime.parse(event.datep2.to_s).minute
      if(minute < 10)
        minute_s = '0'+minute.to_s
      else
        minute_s = minute.to_s
      end
    rescue ArgumentError
      minute_s = '00'
    end
    minute_s
  end

  def self.end_day(event)
    day = event.fulldayevent ? Date.parse(event.datep.to_s).day : Date.parse(event.datep2.to_s).day
    day_s = ''
    if(day < 10)
      day_s = '0'+day.to_s
    else
      day_s = day.to_s
    end
    day_s
  end

  def self.end_month(event)
    month = event.fulldayevent ? Date.parse(event.datep.to_s).month : Date.parse(event.datep2.to_s).month     
    month_s = ''
    if(month < 10)
      month_s = '0'+month.to_s
    else
      month_s = month.to_s
    end
    month_s
  end

  def self.end_year(event)
    Date.parse(event.datep2.to_s).year
  end

  def self.start_hour(event)
    hour = event.fulldayevent ? 0 : DateTime.parse(event.datep.to_s).hour
    hour_s = ''
    if(hour < 10)
      hour_s = '0'+hour.to_s
    else
      hour_s = hour.to_s
    end
    hour_s
  end

  def self.start_minute(event)
    minute = event.fulldayevent ? 0 : DateTime.parse(event.datep.to_s).minute
    minute_s = ''
    if(minute < 10)
      minute_s = '0'+minute.to_s
    else
      minute_s = minute.to_s
    end
    minute_s
  end

  def self.start_day(event)
    day = Date.parse(event.datep.to_s).day
    day_s = ''
    if(day < 10)
      day_s = '0'+day.to_s
    else
      day_s = day.to_s
    end
    day_s
  end

  def self.start_month(event)
    month = Date.parse(event.datep.to_s).month
    month_s = ''
    if(month < 10)
      month_s = '0'+month.to_s
    else
      month_s = month.to_s
    end
    month_s
  end

  def self.start_year(event)
    Date.parse(event.datep.to_s).year
  end

  def self.start_date(event)
    begin
      Date.parse(event.datep.to_s)
    rescue ArgumentError
      ""
    end
  end

  def self.end_date(event)
    begin
      event.fulldayevent ? Date.parse(event.datep.to_s) : Date.parse(event.datep2.to_s)
    rescue ArgumentError
      ""
    end
  end

end
