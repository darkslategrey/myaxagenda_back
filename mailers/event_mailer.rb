# -*- coding: utf-8 -*-
require 'action_mailer'
require 'active_support'

require 'logger'
require './helpers/utils'
require 'active_record'

require './models/jd_db'
require './models/je_db'
require './models/cal_db'

require './models/calendar'
require './models/event_alert'



require './models/event_type'
require './models/event_type_je'
require './models/event_type_jd'

require './models/event'
require './models/event_je'
require './models/event_jd'

require './models/jd_user'
require './models/je_user'

require './models/je_societe'
require './models/jd_societe'

require './models/je_contact'
require './models/jd_contact'

require './models/upload'



class EventMailer < ActionMailer::Base

  mailer_config = YAML.load_file(File.join(File.dirname(__FILE__), '../config/mailer.yml'))

  @@logger = Logger.new(STDOUT)

  ActionMailer::Base.smtp_settings = mailer_config['smtp_settings']
  default = mailer_config['default']

  def send_weekly(dest, subject, body)
    subject += " : Récapitulatif des tâches de la semaine à venir"
    cc = ""
    if dest != "mvignes@jobenfance.com"
      cc = "mvignes@jobenfance.com"
    end
    mail(:to => dest, :cc => cc, :subject => subject) do |format|
      format.text { render :text => body }
    end
  end

  def send_daily(dest, subject, body)
    subject += " : Récapitulatif des tâches de la journée"
    cc = ""
    if dest != "mvignes@jobenfance.com"
      cc = "mvignes@jobenfance.com"
    end
    mail(:to => dest, :cc => cc, :subject => subject) do |format|
      format.text { render :text => body }
    end
  end

  def send_regie_alert(dests, subject, body, filename)
    if not filename.nil?
      attachments.inline[File.basename(filename)] = File.read(filename)
    end
    mail(:to => dests, :subject => subject) do |format|
      format.text { render :text => body }
    end
  end

end

