require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'pry'

get '/' do
	erb "Hello! <a href=\"https://github.com/bootstrap-ruby/sinatra-bootstrap\">Original</a> pattern has been modified for <a href=\"http://rubyschool.us/\">Ruby School!!!!</a>"			
end

get '/about' do 
	erb :about
end

get '/contacts' do
	erb :contacts
end

get '/visit' do
	erb :visit
end

post '/visit' do
	add_to_clienlist(params[:username], params[:phone], params[:time], params[:barber], params[:colorpicker])
erb :visit
end

def add_to_clienlist(name, phone, time, barber, color)
	output = File.open './public/clientlist.txt', 'a'
	output.write "Client #{name}, contact number: #{phone}, will be on #{time} to #{barber}. Paint to #{color}\n"
	output.close
end