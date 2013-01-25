require 'date'
require 'logger'
require 'fileutils'
require 'active_support/all'


class EventsController




  def get(params)
    @logger = Logger.new(STDOUT)
    events = []
    if params.size == 0 # default current month
      events.push(Event.find_by_month(Date.current))
      # events.push(Event.find_by_datep("2010-06-03T10:37:42+02:00"))
      # events.push(Event.find_by_datep(Date.parse("2010-06-03T10:37:42+02:00")))
    else
      events.push(Event.first)
    end
    # @logger.debug(events)
    # JSON.pretty_generate(json_ob))

  end

end
