require 'active_record'
require 'logger'

require File.join(File.dirname(__FILE__), "/../models/calendar.rb")
require File.join(File.dirname(__FILE__), "/../models/event.rb")

describe "Event" do 

  # it 'Create a new event' do
  #   require 'net/http'
  #   uri = URI('http://localhost:6789/createEditEvent.json')
  #   params = {'calendarId' => 1,
  #     'startDay' => '2013-01-23',
  #     'endDay' => '2013-01-23',
  #     'startHMTime' => '10:00',
  #     'endHMTime' => '11:00',
  #     'repeatType' => 'no',
  #     'alertFlag' => nil,
  #     'locked' => false,
  #     'subject' => 'kdjlksjl',
  #     'description' => 'jkldslkj',
  #     'userId' => 1 }
  #   res = JSON.parse(Net::HTTP.post_form(uri, params).body)
  #   res['success'].should == true
  # end

  it "show all the events" do
    require 'net/http'
    uri = URI('http://localhost:6789/fakeData/listEvent.json')
    res = JSON.parse(Net::HTTP.get(uri))
    puts res
  end

  # it 'Show only Jobenfance regie' do
  #   require 'net/http'
  #   uri = URI('http://localhost:6789/showOnly.json')
  #   params = {'id' => 5, 'userId' => 1 }
  #   res = JSON.parse(Net::HTTP.post_form(uri, params).body)
  #   puts res # res['total'].should > 0
  # end

  # it 'Create update calendar' do
  #   require 'net/http'
  #   uri = URI('http://localhost:6789/createUpdate.json')
  #   params = { 'id'=>4,
  #     'name'=>'Actions Job Enfance',
  #     'description'=>'Actions Job Enfance',
  #     'color'=>'green',
  #     'hide'=>'true',
  #     'userId'=>1 }
  #   res = JSON.parse(Net::HTTP.post_form(uri, params).body)
  #   puts res # res['total'].should > 0
#   end

end
