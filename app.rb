require "sinatra"
require "sinatra/reloader"

api_url = "https://api.exchangerate.host/list?access_key=#{ENV["EXCHANGE_RATE_KEY"]}"
# https://api.exchangerate.host/convert?access_key=EXCHANGE_RATE_KEY&from=USD&to=INR&amount=1


get("/") do
  erb(:home)
end
