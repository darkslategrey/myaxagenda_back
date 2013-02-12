
require File.join('.', File.dirname(__FILE__), 'event_mailer.rb')


def get_regie_events(class_name)
  klass = eval(class_name)
  actions = []

  # alerts = EventAlert.where("event_class_name = '#{class_name}'")
  current_time = DateTime.new(DateTime.current.year, DateTime.current.month, DateTime.current.day)
  alert_date_start = current_time + 3.days
  alert_date_end = alert_date_start + 24.hours
  conditions = "datep >= '"+ alert_date_start.to_s + "' and datep <= '" + alert_date_end.to_s + "'"
  puts conditions
  regie_type = klass.where("code = 'AC_REGIE'").first
  events = regie_type.events.where(conditions)
  events.each { |event| 
    puts event.id
    alert = {}
    emails = EventAlert.where("dol_ev_id = #{event.id}").first.emails.split(',')
    if class_name == 'EventTypeJe'
      uploadJe = Upload.where("ev_id = #{event.id} and classname = 'EventJe'").first
      file = uploadJe.nil? ? nil : uploadJe.filepath
      alert['class_name'] = 'EventJe'
    else
      uploadJd = Upload.where("ev_id = #{event.id} and classname = 'EventJd'").first
      file = uploadJd.nil? ? nil : uploadJd.filepath
      alert['class_name'] = 'EventJd'
    end
    alert['emails']      = emails
    alert['file']        = file
    alert['label']       = event.label
    alert['description'] = event.note
    actions.push(alert)
  }
  actions
end


def build_send_mail(events)
  events.each { |event|
    dests = event['emails']
    body  = event['label'] + "\n" + event['description']
    filename =  event['file']
    puts EventMailer.send_regie_alert(dests, body, filename)
  }
end


regie_events_je = get_regie_events("EventTypeJe")
regie_events_jd = get_regie_events("EventTypeJd")

puts "RegieJe #{regie_events_je.to_s}"
puts "RegieJd #{regie_events_jd.to_s}"

build_send_mail(regie_events_je)
build_send_mail(regie_events_jd)
