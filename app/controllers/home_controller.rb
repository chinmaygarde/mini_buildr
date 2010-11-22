class HomeController < ApplicationController
  get '/?' do
    redirect '/projects'
  end
end
