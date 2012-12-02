require 'tweetstream'
require 'yaml'
require 'json'

class Array
  def extract_options!
    if last.is_a?(Hash) && last.extractable_options?
      pop
    else
      {}
    end
  end
end

class TweetDriver

  @config = {}
  @TweetClient = nil

  def initialize
    
    @config = YAML.load_file('config.yml')

    TweetStream.configure do |c|
      c.consumer_key       = @config['twitter']['consumer_key'] 
      c.consumer_secret    = @config['twitter']['consumer_secret']
      c.oauth_token        = @config['twitter']['oauth_token']
      c.oauth_token_secret = @config['twitter']['oauth_token_secret']
      c.auth_method        = :oauth
    end

    @client = TweetStream::Client.new

  end

  def run
    @client.track(@config['twitter']['hashtags']) do |status|

      require 'debugger'; debugger

      if status.attrs[:retweeted_status] 
        puts 'es un retweet'
        self.retweet(status)
      elsif status.attrs[:in_reply_to_status_id_str] 
        puts 'es un reply'
        self.reply(status)
      else 
        puts 'es uno nuevo'
        self.new(status)
      end
     end
  end

  def retweet(status)
    url = @config['api_host'] + '/twitter/rt'
    data = {
      twitter_reply: status.attrs[:in_reply_to_status_id_str], 
      message: status.attrs[:text], 
      tweet_id: status.attrs[:id_str], 
      user_id: status.attrs[:user][:in_reply_to_status_id_str], 
      image_url: status.attrs[:media][:media_url_https]
    }

    puts data
  end

  def reply(status)

    img = status.attrs[:media][:media_url_https] || '' unless status.attrs[:media].nil?

    url = @config['api_host'] + '/twitter/reply'
    data = {
      message: status.attrs[:text], 
      tweet_id: status.attrs[:id_str], 
      reply_to_id: status.attrs[:in_reply_to_status_id_str],
      user_id: status.attrs[:user][:in_reply_to_status_id_str], 
      image_url: img,
    }

    puts data
  end

  def new(status)

    img =  status.attrs[:media][:media_url_https] || '' unless status.attrs[:media].nil?

    url = @config['api_host'] + '/twitter/new'
    data = {
      text: status.attrs[:text],
      image_url: img,
      latitude: 0,
      longitude: 0,
      twitter_id: status.attrs[:id_str],
      user_id: status.attrs[:user][:in_reply_to_status_id_str]
    }

    puts data
  end

  def post(json, uri)
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Post.new(uri.request_uri, initheader = {'Content-Type' =>'application/json'})
    request.body = json 
    response = http.request(request)
    response
  end

end

daemon = TweetDriver.new
daemon.run

