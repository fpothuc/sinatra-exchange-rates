require "sinatra"
require "sinatra/reloader"
require "http"

# api_url = "https://api.exchangerate.host/list?access_key=#{ENV["EXCHANGE_RATE_KEY"]}"
# https://api.exchangerate.host/convert?access_key=EXCHANGE_RATE_KEY&from=USD&to=INR&amount=1


get("/") do
  # build the API url, including the API key in the query string
  api_url = "https://api.exchangerate.host/list?access_key=#{ENV["EXCHANGE_RATE_KEY"]}"

  # use HTTP.get to retrieve the API information
  raw_data = HTTP.get(api_url)
  
  # convert the raw request to a string
  raw_data_string = raw_data.to_s
  
  # convert the string to JSON
  parsed_data = JSON.parse(raw_data_string)
  
  # get the symbols from the JSON
  currency_hash = parsed_data.fetch("currencies")
  
  @keys_array = currency_hash.keys

  erb(:home)
end

get("/:from_currency") do
  @original_currency = params.fetch("from_currency")

  api_url = "https://api.exchangerate.host/list?access_key=#{ENV["EXCHANGE_RATE_KEY"]}"
  
  # use HTTP.get to retrieve the API information
  raw_data = HTTP.get(api_url)
  
  # convert the raw request to a string
  raw_data_string = raw_data.to_s
  
  # convert the string to JSON
  parsed_data = JSON.parse(raw_data_string)
  
  # get the symbols from the JSON
  currency_hash = parsed_data.fetch("currencies")
  
  @keys_array = currency_hash.keys

  erb(:from)
  # some more code to parse the URL and render a view template
end

get("/:from_currency/:to_currency") do
  @original_currency = params.fetch("from_currency")
  @destination_currency = params.fetch("to_currency")

  api_url = "https://api.exchangerate.host/convert?access_key=#{ENV["EXCHANGE_RATE_KEY"]}&from=#{@original_currency}&to=#{@destination_currency}&amount=1"

    # use HTTP.get to retrieve the API information
    raw_data = HTTP.get(api_url)
  
    # convert the raw request to a string
    raw_data_string = raw_data.to_s
    
    # convert the string to JSON
    @parsed_data = JSON.parse(raw_data_string)
  
  erb(:to)
end
