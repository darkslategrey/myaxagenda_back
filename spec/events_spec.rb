require File.dirname(__FILE__) + "/spec_helper"

describe "Event" do

  def app
    AxAgenda
  end

  it "retrieve all users" do
    get '/users'
    last_response.should be_ok
  end

  it "create alerts on events" do
    data = '{"id":895, "calendarId":1, "startDay":"2013-02-01", "endDay":"2013-02-01", "startHMTime":"10:00", "endHMTime":"11:00", "repeatType":{"rtype":"day","intervalSlot":2,"dspan":20,"beginDay":"2013-01-29","endDay":"2014-01-23"}, "alertFlag":[{"type":"email","early":30,"unit":"minute","emails":"dfd, fdfds"}], "locked":"false,subject","description": "the description" }'
    post '/updateEvent', JSON.parse(data)
    last_response.should be_ok
    json_response = JSON.parse(last_response.body)
    puts json_response['errorInfo']
    json_response['success'].should == true 
  end
end

