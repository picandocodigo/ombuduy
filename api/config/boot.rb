require 'rubygems'

# Set up gems listed in the Gemfile.
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)

require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])

config = YAML.load_file('config/config.yml')
ENV['TWITTER_CONSUMER_KEY'] ||= config['twitter']['consumer_key']
ENV['TWITTER_CONSUMER_SECRET'] ||= config['twitter']['consumer_secret']
