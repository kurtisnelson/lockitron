module Lockitron
  class Lock
    attr_reader :name
    attr_reader :uuid

    # Initializes a lock from a Lockitron JSON representation
    # @param [Hash] JSON
    # @return [Lockitron::Lock]
    def self.from_json blob
      id = blob['id']
      name = blob['name']
      self.new(name: name, uuid: id)
    end

    # A lock
    # @param [Hash] options
    # @options params [String] UUID (Required)
    # @options params [String] Name
    def initialize(params={})
      @uuid = params[:uuid]
      @name = params[:name]
    end

    # Takes a block of actions to perform as user
    # @param user [Lockitron::User]
    def as user
      @user = user
      yield self
      @user = nil
    end

    # Sets up the user context 
    # @param user [Lockitron::User]
    def insert_key user
      @user = user
    end

    # Tears down the user context
    def remove_key
      @user = nil
    end

    # Locks this lock
    # @note Must be performed in user context
    # @return [Hash] API response
    def lock
      require_user
      begin
        @user.post "locks/#{@uuid}/lock"
      rescue ApiError
        false
      end
    end

    # Unlocks this lock
    # @note Must be performed in user context
    # @return [Hash] API response
    def unlock
      require_user
      begin
        @user.post "locks/#{@uuid}/unlock"
      rescue ApiError
        false
      end
    end

    # Invites a user to this lock.
    # @note Must be performed in user context
    #
    # @param [Hash] Options
    # @options params [String] :phone
    # @options params [String] :email
    # @options params [String] :role Defaults to guest
    # @options params [String] :fullname
    # @options params [Time] :start Optional key start time
    # @options params [Time] :expiration Optional key stop time
    # @return [Hash] API response
    def invite(params={})
      require_user
      params[:role] ||= 'guest' 
      raise InvalidArgument, "Phone or email required" unless params[:email] or params[:phone]
      if params[:start]
        params[:start] = params[:start].to_i
      else
        params[:start] = Time.now.to_i
      end
      params[:expiration] = params[:expiration].to_i if params[:expiration]
      @user.post "locks/#{@uuid}/add", params
    end

    private
    def require_user
      raise InvalidArgument, "Not in user context" unless @user
    end
  end
end
