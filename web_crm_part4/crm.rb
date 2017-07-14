require_relative 'contact'

require 'sinatra'



get '/' do
  redirect to ('/contacts')
end


# get '/home' do
#   redirect to ('/')
#   erb :home
# end


get '/contacts' do
  @index_link = 'http://localhost:4567/'
  @contacts = Contact.all
  erb :contacts
end

get '/new' do
  @new_link = 'http://localhost:4567/new'

  erb :new
end

get '/contacts/:id' do
  # params[:id] contains the id from the URL
  @contact = Contact.find_by({id: params[:id].to_i})
  if @contact
    erb :show_contact
  else
    raise Sinatra::NotFound
  end
end


post '/contacts' do
  Contact.create(
    first_name: params[:first_name],
    last_name:  params[:last_name],
    email:      params[:email],
    note:       params[:note]
  )
  redirect to('/contacts')
end


after do
  ActiveRecord::Base.connection.close
end
