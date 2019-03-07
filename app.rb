require 'securerandom'
require 'sinatra'
require 'sinatra/activerecord'
require './models/message'
require 'gibberish'
require 'active_support'

get '/' do
	erb :new
end

post '/submit' do
	@message = Message.new(params[:message])
	if @message.save
		redirect '/messages'
	else
		"Sorry, there was an error!"
	end
end

get '/messages' do
	@messages = Message.all
	erb :messages
end

get '/messages/:slug' do
	@message = Message.find_by_link(params[:slug])
	not_found unless @message

	case @message.destruction_policy
	when "first_visit"
		Message.destroy(@message.id)
	when "one_hour"
		@message.update!(opened_at: Time.now) if @message.opened_at.blank?
		if @message.opened_at < (Time.now - 1.hour)
			Message.destroy(@message.id)
			not_found
		end
	end

	erb :show
end

def not_found
	"404 - Page not found"
end