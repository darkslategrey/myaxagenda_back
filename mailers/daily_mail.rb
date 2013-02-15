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
      users = JeUser.where("login != 'Mathilde'").map { |u| u if not u.email == "" }.compact
    else
      users = JdUser.where("login != 'Mathilde'").map { |u| u if not u.email == "" }.compact
    end
    actions = {}
    current_time = DateTime.current 
    start_day = DateTime.new(DateTime.current.year, DateTime.current.month, DateTime.current.day)
    end_day = start_day + 24.hours

    conditions = "datep >= '" + start_day.to_s + "' and datep <= '" + end_day.to_s + "' and percent != 100"
    events = klass.where(conditions).order('datep')

    events.each { |e| 
      next if e.user_todo.nil?
      next if e.event_type.code == 'AC_REGIE'
      if actions[e.user_todo].nil?
        actions[e.user_todo] = []
      end
      actions[e.user_todo].push(e)
    }
    # les users sans actions
    (Set.new(users) ^ Set.new(actions.keys)).each { |u|
      actions[u] = []
    }
    actions
  end


  def get_ids(actions)
    ids = ''
    actions.each_key { |user| 
      ids += "\n" + user.email + " : "
      actions[user].each { |event|
        ids += ", " + event.id.to_s
      }
    }
  end

  def build_send_mail(events, subject)

    events.each_key { |e|
      body = ''
      if events[e].size == 0
        body = "Bonjour #{e.login},\nAucune action de prévue.\n"
        body += "Bonne journée"
        EventMailer.send_daily(e, subject, body).deliver
        next
      end
      body += "Bonjour #{e.login},\n"
      events[e].each { |a|
        # next if a.societe.nil? and a.contact.nil?
        name = a.contact.nil? ? '' : a.contact.name
        firstname = a.contact.nil? ? '' : a.contact.firstname
        nom_societe = a.societe.nil? ? '' : a.societe.nom
        mobile_contact = a.contact.phone_mobile.nil? ? '' : a.contact.phone_mobile
        tel_contact = a.contact.phone.nil? ? '' : a.contact.phone

        body += "\nSociété : " + nom_societe
        if name.length != 0
          body += " / contact : " + firstname + " " + name + "\n"
        end
        body += "mobile : #{mobile_contact} / tel : #{tel_contact}\n"
        body += "Sujet : " + a.label + "\n"
        body += "Description : " + a.note + "\n\n"
        body += "========================\n\n"
      }
      body += "Bon courage et bonne journée\n"
      EventMailer.send_daily(e, subject, body).deliver
    }
  end


  def run
    daily_events_je = get_daily_events("EventJe")
    daily_events_jd = get_daily_events("EventJd")

    @logger.info "Nbr actions JE quot. #{daily_events_je.size} ids <" + get_ids(daily_events_je).to_s + ">"
    @logger.info "Nbr actions JD quot. #{daily_events_jd.size} ids <" + get_ids(daily_events_jd).to_s + ">"

    build_send_mail(daily_events_je, "Actions Jobenfance")
    build_send_mail(daily_events_jd, "Actions Jobdependance")
  end

end

daily_mailer = DailyMailer.new
daily_mailer.run
daily_mailer.logger.close


