require 'sinatra'
require 'pony'



 
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



post '/msg' do
  options = 
  {
    :to => params[:email],
    :from => 'put your email here',
    :subject => 'Test',
    :body => 'Test Text',
    :html_body => @params[:text],
    :via => :smtp,
    :via_options => 
      {
      :address => 'smtp.gmail.com',
      :port => 587,
      :enable_starttls_auto => true,
      :user_name => 'put your email here',
      :password => 'put your password',
      :authentication => :plain,
      :domain => 'localhost'
      }
  }
  
  redirect '/sended'
  Pony.mail(options)
end

get '/sended' do
  
  puts @params[:text]
  erb :sended
end



