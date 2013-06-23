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
CLIENT_ID = 'f0605493712611e3fd2e53b96b0b54836b11d1b05985cc1f908e7a149a7bf5c4'
ENV['CLIENT_SECRET'] ||= 'yay_client_secret'
CLIENT_SECRET = ENV['CLIENT_SECRET']
REDIRECT_URI = 'http://lockitron.com'
ENV['AUTH_CODE'] = 'yay_auth_code'
AUTH_CODE = ENV['AUTH_CODE']
ENV['OAUTH_TOKEN'] ||= 'yay_auth_token'
OAUTH_TOKEN = ENV['OAUTH_TOKEN']
VIRTUAL_LOCK_NAME = 'Gem Test'
VIRTUAL_LOCK_UUID = 'a397ef51-7b33-46dd-9a96-53eb1a7ea07f'

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
