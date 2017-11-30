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

  get '/teams/:slug' do
    @team = Team.find_by_slug(parmas[:slug])

    erb :'teams/show'
  end

  get '/teams/new' do
    if logged_in?
      erb :'teams/new'
    else
      redirect '/login'
    end
  end

end
