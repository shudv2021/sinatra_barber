require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'pry'
require 'sqlite3'

def get_db
	return SQLite3::Database.new 'barber_shop.db'
end

configure do
	db = get_db
	db.execute 'CREATE TABLE IF NOT EXISTS "users"
														("id" INTEGER PRIMARY KEY AUTOINCREMENT,
															"name" TEXT NOT NULL,
															"phone" TEXT NOT NULL,
															"data" TEXT NOT NULL,
															"barber" TEXT NOT NULL,
															"color" TEXT NOT NULL);
							'
end

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
	@name = params[:username]
	@phone =  params[:phone]
	@time = params[:time]
	@barber = params[:barber]
	@color = params[:colorpicker]
	errors = {:username =>'Заполните поле имя', :phone => 'Запишите номер телефона', :time => 'Выберите время'}
	
		@error = errors.select{ |key,_| params[key].empty?}.values.join(', ')

		add_to_db(@name, @phone, @time, @barber, @color) if @error.empty?

erb :visit
end

def add_to_db(name, phone, time, barber, color)
	db = get_db
	db.execute 'insert into "users" (
		name,
		phone,
		data,
		barber,
		color
	) values(?, ?, ?, ?, ?)', [name, phone, time, barber, color]
end

get '/list' do
	db  = get_db
	@db_arr = []
	db.results_as_hash = true
	db.execute 'select * from users' do |row|
	@db_arr << row
	end
	erb :list
end