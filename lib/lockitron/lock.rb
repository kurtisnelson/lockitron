module Lockitron
  class Lock
    attr_reader :name
    attr_reader :uuid
    attr_reader :latitude, :longitude, :keys, :status

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
    # @option params [String] UUID (Required)
    # @option params [String] Name
    # @option params [Lockitron::User] User
    def initialize(params={})
      @uuid = params[:uuid]
      @name = params[:name]
      @user = params[:user]
      refresh if @user #if we have credentials, go ahead and sync with the API
    end

    # Takes a block of actions to perform as user
    # @param user [Lockitron::User]
    def as user
      insert_key user
      yield self
      remove_key
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
        @status = "lock"
      rescue ApiError
        false
      end
    end

    # @return [boolean] door is locked
    def locked?
      return @status == "lock"
    end

    # @return [boolean] door is unlocked
    def unlocked?
      return @status == "unlock"
    end

    # Unlocks this lock
    # @note Must be performed in user context
    # @return [Hash] API response
    def unlock
      require_user
      begin
        @user.post "locks/#{@uuid}/unlock"
        @status = "unlock"
      rescue ApiError
        false
      end
    end

    # Syncs the lock's status
    # @note Must be performed with user context
    def refresh
      require_user
      lock = @user.get "locks/#{@uuid}"
      @name = lock['lock']['name']
      @status = lock['lock']['status']
      @latitude = lock['lock']['latitude']
      @longitude = lock['lock']['longitude']
      @keys = lock['lock']['keys']
    end

    # Invites a user to this lock.
    # @note Must be performed in user context
    #
    # @param [Hash] Options
    # @option params [String] :phone
    # @option params [String] :email
    # @option params [String] :role Defaults to guest
    # @option params [String] :fullname
    # @option params [Time] :start Optional key start time
    # @option params [Time] :expiration Optional key stop time
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
