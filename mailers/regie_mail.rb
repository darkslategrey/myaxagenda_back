# -*- coding: utf-8 -*-

require File.join('.', File.dirname(__FILE__), 'event_mailer.rb')



class RegieMailer

  attr_accessor :logger

  def initialize
    @logger = Logger.new("log/mailer.log")
    original_formatter = Logger::Formatter.new
    @logger.formatter = proc { |severity, datetime, progname, msg|
      original_formatter.call(severity, datetime, progname, msg)
    }
    
  end

  def get_regie_events(class_name, day_nbr)
    klass = eval(class_name)
    actions = []

    current_time = DateTime.new(DateTime.current.year, DateTime.current.month, DateTime.current.day)
    alert_date_start = current_time + day_nbr.days
    alert_date_end = alert_date_start + 24.hours
    conditions = "datep >= '"+ alert_date_start.to_s + "' and datep <= '" + alert_date_end.to_s + "'"
    regie_type = klass.where("code = 'AC_REGIE'").first
    events = regie_type.events.where(conditions)
    events.each { |event| 
      alert = {}
      ev_alert = EventAlert.where("dol_ev_id = #{event.id}").first
      next if ev_alert.nil?
      emails = ev_alert.emails.split(',')
      if class_name == 'EventTypeJe'
        uploadJe = Upload.where("ev_id = #{event.id} and classname = 'EventJe'").first
        file = uploadJe.nil? ? nil : uploadJe.filepath
        alert['class_name'] = 'EventJe'
      else
        uploadJd = Upload.where("ev_id = #{event.id} and classname = 'EventJd'").first
        file = uploadJd.nil? ? nil : uploadJd.filepath
        alert['class_name'] = 'EventJd'
      end
      alert['ev_id']       = event.id.to_s
      alert['emails']      = emails.map { |e| e.gsub(/s/, '') }
      alert['file']        = file
      alert['label']       = event.label
      alert['description'] = event.note
      actions.push(alert)
    }
    actions
  end


  def build_send_mail(events, subject)
    return if events.size == 0
    events.each { |event|
      dests = event['emails']
      body  = event['label'] + "\n" + event['description']
      filename =  event['file']
      dests.map! { |e| e.gsub(/\s/, '') }
      @logger.info("regies : <"+dests.to_s+">")
      EventMailer.send_regie_alert(dests, subject, body, filename).deliver
    }
  end


  def get_ids(regies)
    ids = ''
    regies.each { |r| ids += ", " + r['ev_id'] }
    ids.sub(/^../, '')
  end

  def run
    re_je_3 = get_regie_events("EventTypeJe", 3)
    re_je_1 = get_regie_events("EventTypeJe", 1)

    re_jd_3 = get_regie_events("EventTypeJd", 3)
    re_jd_1 = get_regie_events("EventTypeJd", 1)


    @logger.info "Nbr RegieJe à 3 jrs  #{re_je_3.size} ids <" + get_ids(re_je_3) + ">"
    @logger.info "Nbr RegieJe à 1 jrs  #{re_je_1.size} ids <" + get_ids(re_je_1) + ">"

    @logger.info "Nbr RegieJd à 3 jrs  #{re_jd_3.size} ids <" + get_ids(re_jd_3) + ">"
    @logger.info "Nbr RegieJd à 1 jrs  #{re_jd_1.size} ids <" + get_ids(re_jd_1) + ">"

    build_send_mail(re_je_3, "Message auto: Bannières Jobenfance à 3 jours")
    build_send_mail(re_je_1, "Message auto: Bannières Jobenfance à 1 jours")

    build_send_mail(re_jd_3, "Message auto: Bannières Jobdependance à 3 jours")
    build_send_mail(re_jd_1, "Message auto: Bannières Jobdependance à 1 jours")
  end

end


regie_mailer = RegieMailer.new
regie_mailer.run
regie_mailer.logger.close



