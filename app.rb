require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'pry'
require 'sqlite3'

configure do
	@db = SQLite3::Database.new 'barber_shop.db'
	@db.execute 'CREATE TABLE "users"
														("id" INTEGER PRIMARY KEY AUTOINCREMENT,
															"name" TEXT NOT NULL,
															"phone" TEXT NOT NULL,
															"data" TEXT NOT NULL,
															"barber" TEXT NOT NULL,
															"color" TEXT NOT NULL);
							'
end

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
	errors = {:username =>'Заполните поле имя', :phone => 'Запишите номер телефона', :time => 'Выберите время'}
	
		@error = errors.select{ |key,_| params[key].empty?}.values.join(', ')

		add_to_clienlist(@name, @phone, @time, @barber, @color) if @error.empty?

erb :visit
end

def add_to_clienlist(name, phone, time, barber, color)
	output = File.open './public/clientlist.txt', 'a'
	output.write "Client #{name}, contact number: #{phone}, will be on #{time} to #{barber}. Paint to #{color}\n"
	output.close
end