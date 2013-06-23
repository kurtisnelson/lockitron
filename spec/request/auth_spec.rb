require_relative '../spec_helper'

describe Lockitron::Auth do
  let(:auth) {Lockitron::Auth.new(client_id: CLIENT_ID, client_secret: CLIENT_SECRET, redirect_uri: REDIRECT_URI)}
  it "can provide auth URL" do
    auth.authorization_url.should include CLIENT_ID
    auth.authorization_url.should include REDIRECT_URI
  end

  it "takes an authorization code and gets a token" do
    VCR.use_cassette 'oauth' do
      auth.token_from_code AUTH_CODE
    end
    auth.token.should_not be_empty
  end
end
