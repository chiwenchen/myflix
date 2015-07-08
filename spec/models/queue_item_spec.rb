require 'spec_helper'

describe QueueItem do 
  it { should belong_to(:user)}
  it { should belong_to(:video)}

  describe '#video_title' do 
    it 'return the title of the accossiated video' do 
      video = Fabricate(:video, title: 'Monk')
      queue_item = Fabricate(:queue_item, video: video)
      expect(queue_item.video_title).to eq('Monk')
    end
  end

  describe '#rating' do 
    it 'returns the rating from the review when the review is present' do 
      video = Fabricate(:video)
      user =Fabricate(:user)
      review = Fabricate(:review, video: video, user: user)
      queue_item = Fabricate(:queue_item, video: video, user: user)
      expect(queue_item.rating).to eq(review.rating)
    end
    it 'returns nil when the review is not present' do 
      video = Fabricate(:video)
      user =Fabricate(:user)
      queue_item = Fabricate(:queue_item, video: video, user: user)
      expect(queue_item.rating).to eq(nil)
    end
  end

  describe '#category_title' do 
    it 'returns the title of the accossiated category' do 
      category = Fabricate(:category, title: 'Comic')
      video = Fabricate(:video, category: category)
      queue_item = Fabricate(:queue_item, video: video)
      expect(queue_item.category_title).to eq('Comic')
    end
  end

  describe '#category' do 
    it 'returns the title of the accossiated category' do 
      category = Fabricate(:category, title: 'Comic')
      video = Fabricate(:video, category: category)
      queue_item = Fabricate(:queue_item, video: video)
      expect(queue_item.category).to eq(category)
    end
  end
end 