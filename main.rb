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
    :from => 'nneowoolf@gmail.com',
    :subject => 'Test',
    :body => 'Test Text',
    :html_body => params[:text],
    :via => :smtp,
    :via_options => 
      {
      :address => 'smtp.gmail.com',
      :port => 587,
      :enable_starttls_auto => true,
      :user_name => '',
      :password => '',
      :authentication => :plain,
      :domain => 'localhost'
      }
  }
  @result = "Хер знает что"
  Pony.mail(options)

  #redirect '/sended'
  end


get '/sended' do
  erb :sended
end

#get '/msg' do

 # erb :msg
#end

