require 'sinatra'
require 'twilio-ruby'
require 'pry'

Twilio.configure do |config|
  config.account_sid = ENV['ACCOUNT_SID']
  config.auth_token = ENV['AUTH_TOKEN']
end

client = Twilio::REST::Client.new

# client.messages.create(
#   from: '+17819173042',
#   to: '+18575769651',
#   body: 'It\'s such a good vibration',
#   media_url: 'http://i.imgur.com/HefNmTU.jpg'
# )

get '/' do
  client = Twilio::REST::Client.new
  @messages = client.messages.list(to: '+17819173042')

  erb :index
end

get '/conversations/:sender_number' do
  client = Twilio::REST::Client.new
  @sender_number = params[:sender_number]

  incoming = client.messages.list(from: @sender_number, to: '+17819173042')
  outgoing = client.messages.list(from: '+17819173042', to: @sender_number)

  @messages = incoming + outgoing
  erb :'conversations/show'
end
