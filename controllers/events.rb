require 'date'
require 'logger'
require 'fileutils'
require 'active_support/all'

class EventsController

  @@logger = Logger.new(STDOUT)

  def initialize(params={})
  end

  def self.find_by_month(date)
    prev_month = date - 1.month
    next_month = date + 1.month


    events_je = EventJe.where("datep < '" + next_month.to_s + "' and datep > '" + prev_month.to_s + "'")
    events_jd = EventJd.where("datep < '" + next_month.to_s + "' and datep > '" + prev_month.to_s + "'")
    
    @@logger.debug(": nbr of jd events <#{events_jd.size}>")
    @@logger.debug(": jd class <#{events_jd[0].class}>")
    @@logger.debug(": nbr of je events <#{events_je.size}>")
    @@logger.debug(": je class <#{events_je[0].class}>")
    
    all_events = events_je + events_jd
    @@logger.debug(": total : #{all_events.size}")
    all_events
  end

  def self.find_by_calendar(id)

  end


end
