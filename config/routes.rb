DataInsightFrontend::Application.routes.draw do

  root :to => redirect("/performance")

  scope "/performance" do
    match "/" => "root#index", via: :get, as: 'root'
    match "dashboard" => "dashboard#index", via: :get
    match "dashboard/narrative" => "dashboard#narrative", via: :get
    match "dashboard/visits" => "dashboard#visits", via: :get
    match "dashboard/unique-visitors" => "dashboard#unique_visitors", via: :get
    match "dashboard/format-success" => "dashboard#format_success", via: :get
    match "dashboard/hourly-traffic" => "dashboard#hourly_traffic", via: :get

    if Rails.env.development? or Rails.env.test?
      match "dev/inside-government" => "inside_government#index", via: :get
      match "dev/inside-government/format-success" => "inside_government#format_success", via: :get
    end
  end

end
