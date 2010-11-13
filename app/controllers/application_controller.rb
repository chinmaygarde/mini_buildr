class ApplicationController < Sinatra::Base
  helpers UserHelpers
  helpers Sinatra::ContentFor
  
  enable :sessions
  
  use OmniAuth::Builder do
    provider :twitter,  Application::AUTH_TOKENS["twitter"]["consumer_key"], Application::AUTH_TOKENS["twitter"]["consumer_secret"]
    provider :facebook, Application::AUTH_TOKENS["facebook"]["app_id"], Application::AUTH_TOKENS["facebook"]["app_secret"]
    provider :github,   Application::AUTH_TOKENS["github"]["client_id"], Application::AUTH_TOKENS["github"]["secret"]
  end
  
  get '/login' do
    haml :login
  end
  
  get '/auth/:name/callback' do
    auth = request.env['omniauth.auth']

    auth_record = Authentication.find(:first, :conditions => { :provider => auth['provider'], :uid => auth['uid'] })
    if !auth_record.nil?
      # Existing User
      current_user = auth_record.user
    else
      # New User
      auth_record = Authentication.create!(:provider => auth['provider'], :uid => auth['uid'])
      handle = auth['user_info']['name'] || auth['user_info']['nickname'] || auth['user_info']['email'] || 'J Doe'      
      auth_record.user = User.create!(:handle => handle)
      current_user = auth_record.user
    end
    redirect '/projects'
  end
  
  get '/logout' do
    session[:user_id] = nil
    redirect '/projects'
  end
  
  protected
  
  def current_user
    begin
      user = User.find(:conditions => session[:user_id])      
    rescue
    end
    @current_user ||= user
  end

  def signed_in?
    !!current_user
  end
  
  def current_user=(user)
    @current_user = user
    session[:user_id] = user.id.to_s
  end
end