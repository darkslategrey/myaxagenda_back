# -*- coding: utf-8 -*-
require './mailers/event_mailer'


def get_daily_events(class_name)
  klass = eval(class_name)
  actions = {}
  current_time = DateTime.current 
  start_day = DateTime.new(DateTime.current.year, DateTime.current.month, DateTime.current.day)
  start_day = start_day
  end_day = start_day + 24.hours
  # end_day -= 1.seconds  # DateTime.new(DateTime.current.year, DateTime.current.month, DateTime.current.day) + 24.hours
  conditions = "datep >= '" + start_day.to_s + "' and datep <= '" + end_day.to_s + "' and percent != 100"
  events = klass.where(conditions)
  puts conditions
  events.each { |e| 
    next if e.user_todo.nil?
    next if e.event_type.code == 'AC_REGIE'
    if actions[e.user_todo.email].nil?
      actions[e.user_todo.email] = []
    end
    actions[e.user_todo.email].push(e)
  }
  actions
end


def build_send_mail(events)
  puts "events <#{events.to_s}>"
  events.each_key { |e|
    puts "to #{e} #{events[e].size} actions"
    body = ''
    events[e].each { |a|
      next if a.societe.nil? and a.contact.nil?
      name = a.contact.nil? ? '' : a.contact.name
      firstname = a.contact.nil? ? '' : a.contact.firstname
      nom_societe = a.societe.nil? ? '' : a.societe.nom
      body += "\nSociété : " + nom_societe
      if name.length != 0
        body += " / contact : " + firstname + " " + name
      end
      body += " : " + a.label
    }
    EventMailer.send_daily(e, body).deliver
  }
end

daily_events_je = get_daily_events("EventJe")
daily_events_jd = get_daily_events("EventJd")

build_send_mail(daily_events_je)
build_send_mail(daily_events_jd)

