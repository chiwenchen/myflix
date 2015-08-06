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
end