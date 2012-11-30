require "functional/rack_test_helper"

describe "Dashboard API" do

  it "should serve the narrative as json with appropriate fields" do
    dummy_json = { data: "some data" }.to_json

    FakeWeb.register_uri(:get, "#{Settings.api_urls['todays_activity_base_url']}/narrative", :body => dummy_json)

    get "/performance/dashboard/narrative.json"

    last_response.status.should == 200
    last_response.content_type.should include "application/json"

    json_result = JSON.parse(last_response.body)
    json_result["data"].should == "some data"
    json_result["id"].should == "http://datainsight-frontend.dev.gov.uk/performance/dashboard/narrative.json"
    json_result["web_url"].should == "http://datainsight-frontend.dev.gov.uk/performance/dashboard/narrative"
  end

  it "should serve visits as json with appropriate fields" do
    dummy_json = { data: "some data" }.to_json

    FakeWeb.register_uri(:get, "#{Settings.api_urls['weekly_reach_base_url']}/weekly-visits", :body => dummy_json)

    get "/performance/dashboard/visits.json"

    last_response.status.should == 200
    last_response.content_type.should include "application/json"

    json_result = JSON.parse(last_response.body)
    json_result["data"].should == "some data"
    json_result["id"].should == "http://datainsight-frontend.dev.gov.uk/performance/dashboard/visits.json"
    json_result["web_url"].should == "http://datainsight-frontend.dev.gov.uk/performance/dashboard/visits"
  end

  it "should serve visitors as json with appropriate fields" do
    dummy_json = { data: "some data" }.to_json

    FakeWeb.register_uri(:get, "#{Settings.api_urls['weekly_reach_base_url']}/weekly-visitors", :body => dummy_json)

    get "/performance/dashboard/unique-visitors.json"

    last_response.status.should == 200
    last_response.content_type.should include "application/json"

    json_result = JSON.parse(last_response.body)
    json_result["data"].should == "some data"
    json_result["id"].should == "http://datainsight-frontend.dev.gov.uk/performance/dashboard/unique-visitors.json"
    json_result["web_url"].should == "http://datainsight-frontend.dev.gov.uk/performance/dashboard/unique-visitors"
  end

  it "should serve format success as json with appropriate fields" do
    dummy_json = { data: "some data" }.to_json

    FakeWeb.register_uri(:get, "#{Settings.api_urls['format_success_base_url']}/format-success", :body => dummy_json)

    get "/performance/dashboard/format-success.json"

    last_response.status.should == 200
    last_response.content_type.should include "application/json"

    json_result = JSON.parse(last_response.body)
    json_result["data"].should == "some data"
    json_result["id"].should == "http://datainsight-frontend.dev.gov.uk/performance/dashboard/format-success.json"
    json_result["web_url"].should == "http://datainsight-frontend.dev.gov.uk/performance/dashboard/format-success"
  end

  it "should serve hourly traffic as json with appropriate fields" do
    dummy_json = { data: "some data" }.to_json

    FakeWeb.register_uri(:get, "#{Settings.api_urls['todays_activity_base_url']}/todays-activity", :body => dummy_json)

    get "/performance/dashboard/hourly-traffic.json"

    last_response.status.should == 200
    last_response.content_type.should include "application/json"

    json_result = JSON.parse(last_response.body)
    json_result["data"].should == "some data"
    json_result["id"].should == "http://datainsight-frontend.dev.gov.uk/performance/dashboard/hourly-traffic.json"
    json_result["web_url"].should == "http://datainsight-frontend.dev.gov.uk/performance/dashboard/hourly-traffic"
  end
end