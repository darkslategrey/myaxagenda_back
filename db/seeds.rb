# -*- coding: utf-8 -*-
require 'active_record'
require 'logger'
require './models/calendar.rb'
require './models/event_types.rb'

Calendar.find_by_code('ACTIONS_JOBENFANCE') || Calendar.create(:name => 'Actions Jobenfance',
                                                               :code => 'ACTIONS_JOBENFANCE',
                                                               :description => 'Actions Jobenfance',
                                                               :color => '')
Calendar.find_by_code('ACTIONS_JOBDEPENDANCE') || Calendar.create(:name => 'Actions Jobdependance',
                                                                  :code => 'ACTIONS_JOBDEPENDANCE',
                                                                  :description => 'Actions Jobdependance',
                                                                  :color => '')
Calendar.find_by_code('REGIE_JOBENFANCE') || Calendar.create(:name => 'Bannières Jobenfance',
                                                             :code => 'REGIE_JOBENFANCE',
                                                             :description => 'Bannières Jobenfance',
                                                             :color => '')
Calendar.find_by_code('REGIE_JOBDEPENDANCE') || Calendar.create(:name => 'Bannière Jobdependance',
                                                                :code => 'REGIE_JOBDEPENDANCE',
                                                                :description => 'Bannière Jobdependance',
                                                                :color => '')




je_id = EventTypeJe.last.id.to_i + 10
jd_id = EventTypeJd.last.id.to_i + 10

params = {
  :id => je_id,
  :code => 'AC_REGIE',
  :type => 'user',
  :libelle => 'Bannières Jobenfance',
  :active => 1,
  :position => 30
}

EventTypeJe.find_by_code('AC_REGIE') || EventTypeJe.create(params)
params[:id] = jd_id
params[:libelle] = 'Bannières Jobdependance'
EventTypeJd.find_by_code('AC_REGIE') || EventTypeJd.create(params)



