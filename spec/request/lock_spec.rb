require_relative '../spec_helper'

describe Lockitron::Lock do
  let(:lock) { Lockitron::Lock.new(uuid: VIRTUAL_LOCK_UUID)}
  context "valid user" do
    let(:valid_user) { Lockitron::User.new OAUTH_TOKEN }
    describe '#as' do
      it "unlocks" do
        lock.as valid_user do |l|
          VCR.use_cassette 'unlock' do
            l.unlock
          end
        end
      end

      it "refreshes" do
        lock.as valid_user do |l|
          VCR.use_cassette 'refresh' do
            l.refresh
          end
          l.name.should eq VIRTUAL_LOCK_NAME
        end
      end

      it "refreshes automatically if possible" do
        VCR.use_cassette 'refresh' do
          lock = Lockitron::Lock.new(uuid: VIRTUAL_LOCK_UUID, user: valid_user)
          lock.name.should eq VIRTUAL_LOCK_NAME
        end
      end

      it "locks" do
        lock.as valid_user do |l|
          VCR.use_cassette 'lock' do
            l.lock
          end
        end
      end

      it "invites users" do
        lock.as valid_user do |l|
          VCR.use_cassette 'invite' do
            l.invite email: 'someone@example.com'
            #invite someone for an hour from now
            l.invite email: 'someone2@example.com', start: Time.now + 3200
          end
        end
      end
    end
  end
end
