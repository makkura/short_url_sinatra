# Same as require_relative so we look at the relative path
require File.dirname(__FILE__) + "/app"

# ENV['RACK_ENV'] should be pulled from the apache/passenger config
##set :environment, ENV['RACK_ENV'].to_sym
# Environment may not be forcing the database.
# Possibly use the configure / set code from: http://screencasts.org/episodes/configuring-activerecord-in-sinatra
set :environment, :development
set :app_file, 'app.rb' # sets the main application file
disable :run

# Routes all output to a log file
log = File.new("logs/sinatra.log", "a")
STDOUT.reopen(log)
STDERR.reopen(log)

# Configutation is done, start the program
run Sinatra::Application
