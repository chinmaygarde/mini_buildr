class UserController < ApplicationController
  get '/:user_id/show' do |user_id|
    @user = User.find(user_id)
    haml :user_show
  end
  
  get '/:user_id/edit' do |user_id|
    @user = User.find(user_id)
    haml :user_edit
  end
  
  post '/:user_id/update' do |user_id|
    user = User.find(user_id)
    user.handle = params[:handle] if params[:handle]
    user.email = params[:email] if params[:email]
    user.save
    redirect "/users/#{user.id}/show"
  end
end