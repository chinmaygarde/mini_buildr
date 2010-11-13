class ApplicationController < Sinatra::Base
  helpers UserHelpers
  helpers Sinatra::ContentFor
  
  use OmniAuth::Builder do
    provider :twitter,  Application::AUTH_TOKENS["twitter"]["consumer_key"], Application::AUTH_TOKENS["twitter"]["consumer_secret"]
    provider :facebook, Application::AUTH_TOKENS["facebook"]["app_id"], Application::AUTH_TOKENS["facebook"]["app_secret"]
  end
  
  get "/login" do
    haml :login
  end
end