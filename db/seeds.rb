# -*- coding: utf-8 -*-
require 'active_record'
require 'logger'
require './models/calendar'
require './models/je_db'
require './models/jd_db'
require './models/event_type'
require './models/event_type_je'
require './models/event_type_jd'


Calendar.create(:id => 1,
                :name => 'Actions Jobenfance',
                :code => 'ACTIONS_JOBENFANCE',
                :description => 'Actions Jobenfance',
                :color => '',
                :hide => false)
Calendar.create(:id => 2,
                :name => 'Actions Jobdependance',
                :code => 'ACTIONS_JOBDEPENDANCE',
                :description => 'Actions Jobdependance',
                :color => '',
                :hide => false)
Calendar.create(:id => 3,
                :name => 'Bannières Jobenfance',
                :code => 'REGIE_JOBENFANCE',
                :description => 'Bannières Jobenfance',
                :hide => true,
                :color => '')
Calendar.create(:id => 4,
                :name => 'Bannières Jobdépendance',
                :code => 'REGIE_JOBDEPENDANCE',
                :description => 'Bannières Jobdépendance',
                :hide => true,
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



