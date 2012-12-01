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

TweetStream::Client.new.track('#OmbudUy', '#OMBUDUY') do |status|

  # require 'debugger'; debugger
  if status.attrs[:retweeted_status] 
    puts 'es un retweet'
  elsif status.attrs[:in_reply_to_status_id_str] 
    puts 'es un reply'
  else 
    puts 'es uno nuevo'
  end

end

