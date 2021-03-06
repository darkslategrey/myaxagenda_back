require 'active_record'
require File.join(File.dirname(__FILE__), "/../models/event.rb")



describe "Event" do 
  it 'Create a new event' do
    require 'net/http'
    uri = URI('http://localhost:6789/createEditEvent.json')
    params = {'calendarId' => 1,
      'startDay' => '2013-01-23',
      'endDay' => '2013-01-23',
      'startHMTime' => '10:00',
      'endHMTime' => '11:00',
      'repeatType' => 'no',
      'alertFlag' => nil,
      'locked' => false,
      'subject' => 'kdjlksjl',
      'description' => 'jkldslkj',
      'userId' => 1 }
    res = JSON.parse(Net::HTTP.post_form(uri, params).body)
    res['success'].should == true
  end

  it 'Show only Jobenfance regie' do
    require 'net/http'
    uri = URI('http://localhost:6789/showOnly.json')
    params = {'id' => 2, 'userId' => 1 }
    res = JSON.parse(Net::HTTP.post_form(uri, params).body)
    res['total'].should > 0
  end

end
