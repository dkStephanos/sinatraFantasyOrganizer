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

  get '/teams/new' do
    if logged_in?
      erb :'teams/new'
    else
      redirect '/login'
    end
  end

  post '/teams' do
    @team = Team.create(params[:team])
  end

  get '/teams/:slug' do
    @team = Team.find_by_slug(params[:slug])

    erb :'teams/show'
  end

end
