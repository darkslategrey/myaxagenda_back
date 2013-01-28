# -*- coding: utf-8 -*-
require 'active_record'
require 'logger'
require './models/calendar.rb'
require './models/event_types.rb'

Calendar.find_by_code('REGIE_JOBENFANCE') || Calendar.create(:name => 'Régie Jobenfance',
                                                             :code => 'REGIE_JOBENFANCE',
                                                             :description => 'Régie Jobenfance',
                                                             :color => '')
Calendar.find_by_code('REGIE_JOBDEPENDANCE') || Calendar.create(:name => 'Régie Jobdependance',
                                                                :code => 'REGIE_JOBDEPENDANCE',
                                                                :description => 'Régie Jobdependance',
                                                                :color => '')
Calendar.find_by_code('ACTIONS_JOBENFANCE') || Calendar.create(:name => 'Actions Jobenfance',
                                                               :code => 'ACTIONS_JOBENFANCE',
                                                               :description => 'Régie Jobenfance',
                                                               :color => '')
Calendar.find_by_code('ACTIONS_JOBDEPENDANCE') || Calendar.create(:name => 'Actions Jobdependance',
                                                                  :code => 'ACTIONS_JOBDEPENDANCE',
                                                                  :description => 'Régie Jobdependance',
                                                                  :color => '')



je_id = EventTypeJe.last.id.to_i + 10
jd_id = EventTypeJd.last.id.to_i + 10

params = {
  :id => je_id,
  :code => 'AC_REGIE',
  :type => 'user',
  :libelle => 'Régie Jobenfance',
  :active => 1,
  :position => 30
}

EventTypeJe.find_by_code('AC_REGIE') || EventTypeJe.create(params)
params[:id] = jd_id
params[:libelle] = 'Régie Jobdependance'
EventTypeJd.find_by_code('AC_REGIE') || EventTypeJd.create(params)



