source 'https://rubygems.org'

gem 'httparty'
gem 'nokogiri'
gem 'model_un'
gem 'aws-sdk'
gem 'timecop'

group :development do
  gem 'pry'
  gem 'capistrano', '>= 3.0.0.pre13'
  gem 'capistrano-spree', :git => 'git@github.com:spree/capistrano-spree.git', :require => nil
end

group :test do
  gem 'rspec'
  gem 'guard-rspec'
  gem 'terminal-notifier-guard'
  gem 'rb-fsevent', '~> 0.9.1'
  gem 'rack-test'
  gem 'webmock'
  gem 'vcr'
end

group :production do
  gem 'foreman'
  gem 'unicorn'
end

gem 'sinatra'
gem 'tilt', '~> 1.4.1'
gem 'tilt-jbuilder', require: 'sinatra/jbuilder'
gem 'endpoint_base', :github => 'spree/endpoint_base'
