# -*- coding: utf-8 -*-
require './mailers/event_mailer'



def get_weekly_events(class_name)
  klass = eval(class_name)
  actions = {}
  current_time = DateTime.current
  end_week = current_time + 5.days
  conditions = "datep >= '" + current_time.to_s + "' and datep <= '" + end_week.to_s + "' and percent != 100"
  events = klass.where(conditions)
  events.each { |e| 
    next if e.user_todo.nil? or e.label.nil? or e.label.length == 0
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
    EventMailer.send_weekly(e, body).deliver
  }
end


weekly_events_je = get_weekly_events("EventJe")
weekly_events_jd = get_weekly_events("EventJd")

build_send_mail(weekly_events_je)
build_send_mail(weekly_events_jd)
