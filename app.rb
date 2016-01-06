require 'rubygems'  # makes sure the gem's path is available
require 'sinatra'   # required for base sinatra setup	
require 'sinatra/activerecord' # sinatra-activerecord gem allows AR use in Sinatra
require 'haml'                 # Haml allows for nicely written HTML/erb via: http://haml-lang.com/
require 'alphadecimal'         # Converts integers to base 62 strings with a-z via: http://rubygems.org/gems/alphadecimal

# Core object that ties to shortenedurls table (defined in db/migrate/20110719160408_create_shortened_urls.rb
class ShortenedUrl < ActiveRecord::Base
	# validation enforces valid, unqiue url
        # via: http://api.rubyonrails.org/classes/ActiveRecord/Validations/ClassMethods.html
	validates_uniqueness_of :url
	validates_presence_of :url
	validates_format_of :url, :with => /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$/ix

	# Converts the table's ID field to a base 62 value to act as a shortened url
	def shorten
		self.id.alphadecimal
	end
	# Converts a shortened URL back into a full number to look it up in the database
	def self.find_by_shortened(shortened)
		find(shortened.alphadecimal)
	end
end

# This is the base page. It loads /views/index.haml
get '/' do
	haml :index
end

# This is the form submission of the index page
# It uses built in AR .find_or_create_by_ to get or make a new url
# According to the success of this function it reroutes
post '/' do
	@short_url = ShortenedUrl.find_or_create_by_url(params[:url])
	if @short_url.valid?
		haml :success # /views/success.haml
	else
		haml :index   # /views/index.haml
	end
end


# Treats anything after the base path as a short link
# Get the url associated with it and redirect
get '/:shortened' do
	short_url = ShortenedUrl.find_by_shortened(params[:shortened])
	redirect short_url.url
end
