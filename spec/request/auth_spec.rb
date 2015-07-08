require_relative '../spec_helper'

describe Lockitron::Auth do
  let(:auth) {Lockitron::Auth.new(client_id: CLIENT_ID, client_secret: CLIENT_SECRET, redirect_uri: REDIRECT_URI)}
  it "can provide auth URL" do
    expect(auth.authorization_url).to include CLIENT_ID
    expect(auth.authorization_url).to include REDIRECT_URI
  end

  it "takes an authorization code and gets a token" do
    VCR.use_cassette 'oauth' do
      auth.token_from_code AUTH_CODE
    end
    expect(auth.token).to_not be_empty
  end
end
