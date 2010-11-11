class ApplicationController < Sinatra::Base
  helpers UserHelpers
  helpers Sinatra::ContentFor
end