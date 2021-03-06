require "functional/rack_test_helper"

describe "Inside Government API" do

  it "should expose the format success api endpoint" do
    FakeWeb.register_uri(
      :get,
      "#{find_api_url('inside_government_base_url')}/format-success/weekly",
      :body => {my: "json"}.to_json)

    get "/performance/dashboard/government/content-engagement.json"

    last_response.status.should == 200
    last_response.content_type.should include "application/json"

    json_result = JSON.parse(last_response.body)
    json_result["my"].should == "json"
    json_result["id"].should == "http://datainsight-frontend.dev.gov.uk/performance/dashboard/government/content-engagement.json"
  end

  it "should expose most entered policies api endpoint" do
    most_entered_policies = JsonBuilder.most_entered_policies([{}, {}, {}, {}, {}])

    FakeWeb.register_uri(
      :get,
      "#{find_api_url('inside_government_base_url')}/entries/weekly/policies",
      :body => most_entered_policies.to_json)

    get "/performance/dashboard/government/most-entered-policies.json"

    last_response.status.should == 200
    last_response.content_type.should include "application/json"

    json_result = JSON.parse(last_response.body)
    json_result["details"].should == most_entered_policies["details"]
    json_result["id"].should == "http://datainsight-frontend.dev.gov.uk/performance/dashboard/government/most-entered-policies.json"
  end

  it "should expose visitors api endpoint" do
    FakeWeb.register_uri(
      :get,
      "#{find_api_url('inside_government_base_url')}/visitors/weekly?limit=25",
      :body => {data: "some data"}.to_json
    )

    get "/performance/dashboard/government/visitors/weekly.json"

    last_response.status.should == 200
    last_response.content_type.should include "application/json"

    json_result = JSON.parse(last_response.body)
    json_result["data"].should == "some data"
    json_result["id"].should == "http://datainsight-frontend.dev.gov.uk/performance/dashboard/government/visitors/weekly.json"
  end

  it "should expose content engagement detail api endpoint" do
    FakeWeb.register_uri(
      :get,
      "#{find_api_url('inside_government_base_url')}/content-engagement-detail/weekly",
      :body => {data: "some data"}.to_json
    )

    get "/performance/dashboard/government/content-engagement-detail.json"

    last_response.status.should == 200
    last_response.content_type.should include "application/json"

    json_result = JSON.parse(last_response.body)
    json_result["data"].should == "some data"
    json_result["id"].should == "http://datainsight-frontend.dev.gov.uk/performance/dashboard/government/content-engagement-detail.json"
  end

end