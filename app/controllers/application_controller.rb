require './config/environment'
require 'pry'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end

  get '/' do
    erb :'application/homepage'
  end

  get '/login' do
    if logged_in?
      redirect '/teams'
    else
      erb :'application/login'
    end
  end

  post '/login' do
    user = User.find_by(:username => params[:username])

  	 if user && user.authenticate(params[:password])
  			 session[:user_id] = user.id
  			 redirect '/teams'
  	 else
  			 redirect "/failure"
  	 end
  end

  get "/signup" do
    if logged_in?
      redirect "/teams"
    else
      erb :'application/signup'
    end
  end

  post "/signup" do
    if(params[:username] != "" && params[:password] != "")
      user = User.new(:username => params[:username], :password => params[:password])
    else
      redirect "/signup"
    end
		if user.save
       session[:user_id] = user.id
       redirect "/teams"
		else
			 redirect "/failure"
		end
  end

  get "/failure" do
    erb :'application/failure'
  end

  get '/denied' do
    erb :'application/denied'
  end

  get '/invalid' do
    erb :'application/invalid'
  end

  get "/logout" do
    session.clear
    redirect "/"
  end

  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end
  end
end
