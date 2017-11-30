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
      redirect '/homepage'
    end
  end

  post '/teams' do
    valid_data = true
    params[:team].each do |key, value|
      if value == ""
        valid_data = false
      end
    end
    if valid_data
      @team = Team.create(params[:team])
      @team.user_id = current_user.id
      @team.save
    else
      redirect '/invalid'
    end

    redirect '/teams'
  end

  get '/teams/:slug' do
    @team = Team.find_by_slug(params[:slug])

    erb :'teams/show'
  end

  post '/teams/:slug/delete' do
    @team = Team.find_by_slug(params[:slug])
    if current_user.id == @team.user_id
      @team.delete
    else
      redirect '/denied'
    end

    erb :'teams/delete'
  end

  get '/teams/:slug/edit' do
    @team = Team.find_by_slug(params[:slug])

    if logged_in? && current_user.id == @team.user_id
      erb :'teams/edit'
    else
      redirect '/denied'
    end
  end

  post '/teams/:slug' do
    @team = Team.find_by_slug(params[:slug])

    if current_user.id == @team.user_id
      valid_data = true
      params[:team].each do |key, value|
        if value == ""
          valid_data = false
        end
      end

      if valid_data
        @team.update(params[:team])
        @team.save
        redirect "/teams/#{@team.slug}"
      else
        redirect "/invalid"
      end
    else
      redirect '/denied'
    end
  end

end
