# -*- coding: utf-8 -*-
require 'active_record'
require 'logger'
require './models/calendar.rb'

Calendar.create(:name => 'Régie Jobenfance',
                :code => 'REGIE_JOBENFANCE',
                :description => 'Régie Jobenfance',
                :color => '')
Calendar.create(:name => 'Régie Jobdependance',
                :code => 'REGIE_JOBDEPENDANCE',
                :description => 'Régie Jobdependance',
                :color => '')
Calendar.create(:name => 'Actions Jobenfance',
                :code => 'ACTIONS_JOBENFANCE',
                :description => 'Régie Jobenfance',
                :color => '')
Calendar.create(:name => 'Actions Jobdependance',
                :code => 'ACTIONS_JOBDEPENDANCE',
                :description => 'Régie Jobdependance',
                :color => '')
