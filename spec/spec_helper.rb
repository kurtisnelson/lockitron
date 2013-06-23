$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'coveralls'
Coveralls.wear! 'rails'
require 'pry'
require 'rspec'
require 'vcr'

require 'dotenv'
Dotenv.load

require 'lockitron'

#Setup test constants
CLIENT_ID = ENV['CLIENT_ID']
CLIENT_SECRET = ENV['CLIENT_SECRET']
REDIRECT_URI = 'http://lockitron.com'
AUTH_CODE = ENV['AUTH_CODE']
OAUTH_TOKEN = ENV['OAUTH_TOKEN']

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}
VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  c.hook_into :webmock
  c.filter_sensitive_data('<OAUTH_TOKEN>') { ENV['OAUTH_TOKEN'] }
  c.filter_sensitive_data('<CLIENT_SECRET>') { ENV['CLIENT_SECRET'] }
end

RSpec.configure do |config|

end
