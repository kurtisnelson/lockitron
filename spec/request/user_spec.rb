require_relative '../spec_helper'

describe Lockitron::User do
  let(:user) { Lockitron::User.new OAUTH_TOKEN }
  it "lists all the locks" do
    VCR.use_cassette 'user' do
      locks = user.locks
      expect(locks.count).to be > 0
      expect(locks.first).to be_instance_of Lockitron::Lock
    end
  end
end
