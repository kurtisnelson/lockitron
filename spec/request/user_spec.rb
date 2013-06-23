require_relative '../spec_helper'

describe Lockitron::User do
  let(:user) { Lockitron::User.new OAUTH_TOKEN }
  it "lists all the locks" do
    VCR.use_cassette 'user' do
      locks = user.locks
      locks.count.should be > 0
      locks.first.should be_instance_of Lockitron::Lock
    end
  end
end
