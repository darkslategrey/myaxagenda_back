require File.dirname(__FILE__) + "/spec_helper"

describe "App" do

  def app
    AxAgenda
  end

  it "retrieve all users" do
    get '/users'
    last_response.should be_ok
  end

end


