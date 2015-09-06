require 'spec_helper'

describe User do 
  describe '#queued_video' do 
    it 'returns true if video is queued' do
      sammy = Fabricate(:user, name: 'sammy') 
      inception = Fabricate(:video)
      queue_item = Fabricate(:queue_item, video: inception, user: sammy)
      sammy.queued_video(inception).should be true
    end
    it 'returns false if video is not queued' do 
      sammy = Fabricate(:user, name: 'sammy') 
      inception = Fabricate(:video)
      sammy.queued_video(inception).should be false
    end
  end

  describe '#followed?' do 
    it 'returns true if user has followed another user' do 
      sammy = Fabricate(:user)
      bob = Fabricate(:user)
      Relationship.create(leader: bob, follower: sammy)
      expect(sammy.followed?(bob)).to be_true
    end
    it 'returns false if user does not followed another user' do 
      sammy = Fabricate(:user)
      bob = Fabricate(:user)
      Relationship.create(leader: sammy, follower: bob)
      expect(sammy.followed?(bob)).to be_false
    end
  end

  describe '#follow' do 
    it "let the user follow another user" do 
      sammy = Fabricate(:user)
      bob = Fabricate(:user)
      sammy.follow(bob)
      expect(sammy.followed?(bob)).to be_true
    end
  end

  it_behaves_like 'generates_token' do 
      let(:object){Fabricate(:user)}
    end
end