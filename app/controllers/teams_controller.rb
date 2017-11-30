require 'pry'

class TeamsController < ApplicationController

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end

  get '/teams' do
    @user = current_user
    @teams = Team.all

    erb :'teams/teams'
  end

end
