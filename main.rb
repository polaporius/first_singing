require 'sinatra'
require 'pony'
require_relative './helpers/validation'

set :username,'user'
set :token,'shakenN0tstirr3d'
set :password,'resu'

helpers do
  def user? ; request.cookies[settings.username] == settings.token ; end
  def protected! ; halt [ 401, 'Not Authorized' ] unless user? ; end
end

post '/login' do
  if params['username']==settings.username&&params['password']==settings.password
    response.set_cookie(settings.username,settings.token) 
    redirect '/'
  else
    "Username or Password incorrect"
  end
end

post('/logout'){ response.set_cookie(settings.username, false) ; redirect '/' }

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