require 'json'
require_relative 'lock'
module Lockitron
  class User
    def initialize token
      @token = token
    end

    def locks
      get('locks').map {|lock| Lockitron::Lock.from_json lock['lock']} 
    end

    def get action
      resp = Faraday.get "#{API_ENDPOINT}/#{action}", {access_token: @token}
      process resp
    end
    def post action, params = {}
      params.merge!({access_token: @token})
      resp = Faraday.post "#{API_ENDPOINT}/#{action}", params
      process resp
    end

    private
    def process resp
      raise "Not authorized" if resp.status == 403
      raise "Bad API Request: #{resp.status}" unless resp.status == 200
      data = JSON.parse resp.body
    end
  end
end
