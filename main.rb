require 'sinatra'
require 'pony'

EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

get '/' do
  erb :index
end

get '/bio' do
  erb :bio
end

get '/hobby' do
  erb :hobby
end

before '/msg' do
  @errors = []
end

get '/msg' do
  erb :msg
end

post '/msg' do
  @errors << 'Email is not valid'  unless params[:email].match EMAIL_REGEX
  @errors << 'Text must have 1 letter at least' unless params[:text].empty?
  unless @errors.any?
    options = 
    {
      :to => 'nneowoolf@gmail.com',
      :from => params[:email],
      :subject => 'Test',
      :body => 'Test Text',
      :html_body => @params[:text],
      :via => :smtp,
      :via_options => 
        {
        :address => 'smtp.gmail.com',
        :port => 587,
        :enable_starttls_auto => true,
        :user_name => 'nneowoolf@gmail.com',
        :password => 'fgj23hrt23rust',
        :authentication => :plain,
        :domain => 'localhost'
        }
    }  
    redirect '/sended'
    Pony.mail(options)
  else
    erb :msg
  end

end

get '/sended' do
  erb :sended
end



