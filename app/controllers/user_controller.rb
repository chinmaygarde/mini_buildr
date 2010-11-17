class UserController < ApplicationController
  get '/user/:user_id' do |user_id|
    @user = User.find(user_id).first
    haml :user_show
  end
end