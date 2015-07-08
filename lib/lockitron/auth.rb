require 'oauth2'
module Lockitron
  class Auth
    def initialize(params = {})
      @client_id = params[:client_id]
      @client_secret = params[:client_secret]
      @redirect_uri = params[:redirect_uri]
      @oauth_client = OAuth2::Client.new(@client_id, @client_secret, site: API_ENDPOINT)
      @oauth_client.options[:token_url] = "/v2/oauth/token"
    end

    def token_from_code auth_code
      @token = @oauth_client.auth_code.get_token(auth_code, redirect_uri: @redirect_uri)
    end

    def token
      @token.token
    end

    def authorization_url
      "#{Lockitron::API_ENDPOINT}/oauth/authorize?client_id=#{@client_id}&response_type=code&redirect_uri=#{@redirect_uri}"
    end
  end
end
