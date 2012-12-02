require 'tweetstream'
require 'yaml'
require 'json'
require 'geocoder'
require 'em-http-request'

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

    Twitter.configure do |c|
      c.consumer_key       = @config['twitter']['consumer_key'] 
      c.consumer_secret    = @config['twitter']['consumer_secret']
      c.oauth_token        = @config['twitter']['oauth_token']
      c.oauth_token_secret = @config['twitter']['oauth_token_secret']
    end

    @client = TweetStream::Client.new

  end

  def run
    @client.track(@config['twitter']['hashtags']) do |status|

      unless status.attrs[:user][:screen_name] == 'ombuduy' 
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
  end

  def retweet(status)

    url = @config['api_host'] + '/twitter/rt'
    data = {
      tweet_id: status.attrs[:retweeted_status][:id_str]
    }

    puts data
    EventMachine::HttpRequest.new(url, :head => {'Content-Type' =>'application/json'}).post :body => data.to_json 
  end

  def reply(status)

    img = status.attrs[:media][:media_url_https] || '' unless status.attrs[:media].nil?

    url = @config['api_host'] + '/twitter/reply'
    data = {
      message: status.attrs[:text], 
      tweet_id: status.attrs[:id_str], 
      reply_to_id: status.attrs[:in_reply_to_status_id_str],
      user_id: status.attrs[:user][:id_str],
      image_url: img,
    }

    puts data
    EventMachine::HttpRequest.new(url, :head => {'Content-Type' =>'application/json'}).post :body => data.to_json 
  end

  def new(status)

    if status.attrs[:geo]
      case status.attrs[:geo][:type]
      when "Point" then
        latitude = status.attrs[:geo][:coordinates][0]
        longitude = status.attrs[:geo][:coordinates][1]
      when "Polygon" then
        center = Geocoder::Calculations.geographic_center(
                                                          status.attrs[:geo][:coordinates][0],
                                                          status.attrs[:geo][:coordinates][1],
                                                          status.attrs[:geo][:coordinates][2],
                                                          status.attrs[:geo][:coordinates][3]
                                                          )
        latitude, longitude = center[0], center[1]
      end
    end

    img =  status.attrs[:media][:media_url_https] || '' unless status.attrs[:media].nil?

    url = @config['api_host'] + '/twitter/new'
    data = {
      text: status.attrs[:text],
      image_url: img,
      latitude: latitude,
      longitude: longitude,
      tweet_id: status.attrs[:id_str],
      user_id: status.attrs[:user][:id_str]
    }

    puts data

    require 'debugger'; debugger
    puts @config.api_www

    http = EventMachine::HttpRequest.new(url, :head => {'Content-Type' =>'application/json'}).post :body => data.to_json 
    http.callback {
      Twitter.update( '@' + status.attrs[:user][:screen_name] + ' tu issue fue creado en ' + @config['api_www'] + http.response + ' #OmbudUy')
    }
  end

end

daemon = TweetDriver.new
daemon.run
