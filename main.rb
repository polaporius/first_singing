require 'sinatra'
require 'pony'
require 'active_record'
require_relative './helpers/validation'

helpers Valid

ActiveRecord::Base.establish_connection(
  :adapter  => "sqlite3",
  :host     => "localhost",
  :database => "fs1"
)

class User < ActiveRecord::Base
end

ActiveRecord::Migration.create_table :users do |t|
  t.string :name
end

configure do
  enable :sessions
  set :session_secret, 'secret'
end

post '/login' do
  session[:foo] = params[:username], params[:password]
  redirect '/'
end

post '/logout' do
  session.clear
  redirect '/'
end 

get '/' do
  erb :index
end

get '/bio' do
  erb :bio
end

get '/hobby' do
  erb :hobby
end

get '/msg' do
  erb :msg
end

before '/msg' do
  @errors = []
end

post '/msg' do
  validation
  unless @errors.any?
    options = 
    {
      :to => 'nneowoolf@gmail.com',
      :from => params[:from],
      :subject => 'Feedback',
      :body => "from: #{params[:email]}#{params[:text]}",
      :html_body => "from: #{params[:email]} #{params[:text]}",
      :via => :smtp,
      :via_options => 
        {
        :address => 'smtp.gmail.com',
        :port => 587,
        :enable_starttls_auto => true,
        :user_name => 'put your email',
        :password => 'put your pass',
        :authentication => :plain,
        :domain => 'localhost'
        }
    }  
    Pony.mail(options)
    redirect '/sended'
   else
     erb :msg
   end
end

get '/sended' do
  erb :sended
end