$stdout.sync = true

task :console do
  require 'pry'

  require 'rubygems'
  require 'bundler'

  Bundler.require(:default)
  require './fosdick_endpoint'

  def reload!
    # TODO implement reload
  end


  ARGV.clear
  Pry.start
end
