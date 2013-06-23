require_relative '../spec_helper'

describe Lockitron::Lock do
  let(:lock) { Lockitron::Lock.new(uuid: VIRTUAL_LOCK_UUID, name: VIRTUAL_LOCK_NAME)}
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

      it "locks" do
        lock.as valid_user do |l|
          VCR.use_cassette 'lock' do
            l.lock
          end
        end
      end
    end
  end
end
