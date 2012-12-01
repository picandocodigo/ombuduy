require 'tweetstream'

TweetStream.configure do |config|
  config.consumer_key       = 'ulGoRZfmxPK6BfQnBMU7Q'
  config.consumer_secret    = 'rIeggWkOwjk6714h1QsMjyMUM5jdoPfx9mPYCCxMLg'
  config.oauth_token        = '982736767-ivKkzRqTtQ5NZT4uBcjh7p1rGpFIJcKFcCC3LdLw'
  config.oauth_token_secret = 'eU2yA80Sx28ETisrsYwxmw2PQoQUxTufyPBaKRk'
  config.auth_method        = :oauth
end

class Array
  def extract_options!
    if last.is_a?(Hash) && last.extractable_options?
      pop
    else
      {}
    end
  end
end

TweetStream::Client.new.track('#DAL', '#DAL2012') do |status|
  puts "#{status.text}"
  puts status.inspect 
end

