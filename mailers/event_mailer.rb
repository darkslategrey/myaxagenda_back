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

  default :from => mailer_config['default']['from']


  ActionMailer::Base.smtp_settings = mailer_config['smtp_settings']

  def send_weekly(dest, subject, body)
    subject += " : Récapitulatif des tâches de la semaine à venir"
    cc = ['greg.faruch@gmail.com']
    if dest.email != "mvignes@jobenfance.com"
      cc.push "mvignes@jobenfance.com"
    end
    mail(:to => dest.email, :cc => cc, :subject => subject) do |format|
      format.text { render :text => body }
    end
  end

  def send_daily(dest, subject, body)
    subject += " : Récapitulatif des tâches de la journée"
    cc = ['greg.faruch@gmail.com']
    if dest.email != "mvignes@jobenfance.com"
      cc.push "mvignes@jobenfance.com"
    end
    mail(:to => dest.email, :cc => cc, :subject => subject) do |format|
      format.text { render :text => body }
    end
  end

  def send_regie_alert(dests, subject, body, filename)
    if not filename.nil?
      attachments.inline[File.basename(filename)] = File.read(filename)
    end
    dests.push 'greg.faruch@gmail.com'
    mail(:to => dests, :subject => subject) do |format|
      format.text { render :text => body }
    end
  end

end

