require 'pry'
require 'dotenv'

# to call your API keys
Dotenv.load('../.env')

# to get your API key in the ENV varible
ENV['TWITTER_API_SECRET']

def hello
  return "Hello!"
end
