require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'pry'

get '/' do
	@error = "something wrong!"
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
	@name = params[:username]
	@phone =  params[:phone]
	@time = params[:time]
	@barber = params[:barber]
	@color = params[:colorpicker]
	if (@name||@phone||@time||@barber||@color).empty?
		@error = "Заполните все параметры."
		else
		add_to_clienlist(@name, @phone, @time, @barber, @color)
	end
erb :visit
end

def add_to_clienlist(name, phone, time, barber, color)
	output = File.open './public/clientlist.txt', 'a'
	output.write "Client #{name}, contact number: #{phone}, will be on #{time} to #{barber}. Paint to #{color}\n"
	output.close
end