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
    #binding.pry
    erb :'teams/show'
  end

  get '/teams/:slug/edit' do
    @team = Team.find_by_slug(params[:slug])

    if logged_in? && current_user.id = session[:user_id]
      erb :'teams/edit'
    else
      redirect '/login'
    end
  end

  post '/teams/:slug' do
    @team = Team.find_by_slug(params[:slug])
    if current_user.id == @team.user_id
      if params[:team] != nil
        @team.update(params[:team])
        @team.save
        redirect "/teams/#{@team.slug}"
      else
        redirect "/teams/#{@team.slug}/edit"
      end
    else
      redirect '/denied'
    end
  end

end
