# -*- coding: utf-8 -*-
require './mailers/event_mailer'

class DailyMailer

  attr_accessor :logger

  def initialize
    @logger = Logger.new("log/mailer.log")
    original_formatter = Logger::Formatter.new
    @logger.formatter = proc { |severity, datetime, progname, msg|
      original_formatter.call(severity, datetime, progname, msg)
    }
    
  end

  def get_daily_events(class_name)
    klass = eval(class_name)
    if class_name == "EventJe"
      users = JeUser.all.map { |u| u.email if not u.email == "" }.compact
    else
      users = JdUser.all.map { |u| u.email if not u.email == "" }.compact
    end
    actions = {}
    current_time = DateTime.current 
    start_day = DateTime.new(DateTime.current.year, DateTime.current.month, DateTime.current.day)
    start_day = start_day
    end_day = start_day + 24.hours

    conditions = "datep >= '" + start_day.to_s + "' and datep <= '" + end_day.to_s + "' and percent != 100"
    events = klass.where(conditions).order('datep')

    events.each { |e| 
      next if e.user_todo.nil?
      next if e.event_type.code == 'AC_REGIE'
      if actions[e.user_todo.email].nil?
        actions[e.user_todo.email] = []
      end
      actions[e.user_todo.email].push(e)
    }
    # les users sans actions
    (Set.new(users) ^ Set.new(actions.keys)).each { |u|
      actions[u] = []
    }
    actions
  end


  def get_ids(actions)
    ids = ''
    actions.each_key { |email| 
      actions[email].each { |event|
        ids += ", " + event.id.to_s
      }
    }
    ids.sub(/^../, '')
  end


  def build_send_mail(events, subject)

    events.each_key { |e|
      body = ''
      if events[e].size == 0
        body = "Aucune action de prévue.\n"
        body += "Bonne journée"
        EventMailer.send_daily(e, subject, body).deliver
        next
      end
      events[e].each { |a|
        # next if a.societe.nil? and a.contact.nil?
        name = a.contact.nil? ? '' : a.contact.name
        firstname = a.contact.nil? ? '' : a.contact.firstname
        nom_societe = a.societe.nil? ? '' : a.societe.nom
        body += "\nSociété : " + nom_societe
        if name.length != 0
          body += " / contact : " + firstname + " " + name + "\n"
        end
        body += "Sujet : " + a.label + "\n"
        body += "Description : " + a.note + "\n\n"
        body += "========================\n\n"
      }
      EventMailer.send_daily(e, subject, body).deliver
    }
  end


  def run
    daily_events_je = get_daily_events("EventJe")
    daily_events_jd = get_daily_events("EventJd")

    @logger.info "Nbr actions JE quot. #{daily_events_je.size} ids <" + get_ids(daily_events_je) + ">"
    @logger.info "Nbr actions JD quot. #{daily_events_jd.size} ids <" + get_ids(daily_events_jd) + ">"

    build_send_mail(daily_events_je, "Actions Jobenfance")
    build_send_mail(daily_events_jd, "Actions Jobdependance")
  end

end

daily_mailer = DailyMailer.new
daily_mailer.run
daily_mailer.logger.close


