require 'spec_helper'

describe Video do #'describe' is the syntax for test, and the Video is the model name matchs the model we are going to test.

  #shoulda-matchers gem can test common rails functionality
  it {should validate_presence_of(:title)}
  it {should validate_presence_of(:description)}
  it {should belong_to(:category)}

  describe '#search_by_tile' do 
    it 'returns empty array if there is no match' do 
      Fabricate(:video, title: 'interstella')
      expect(Video.search_by_title("family")).to eq([])
    end
    it 'returns an array of one video if there is a complete match' do 
      happy_foot = Fabricate(:video, title: 'Happy foot')
      expect(Video.search_by_title('Happy foot')).to eq([happy_foot])
    end
    it 'returns an array of one video if there is a partial match' do 
      love_world = Fabricate(:video, title: 'love world')
      expect(Video.search_by_title('love')).to eq([love_world])
    end
    it 'returns an array of videos if there is multiple matchs' do 
      love_story = Fabricate(:video, title: 'love story')
      love_world = Fabricate(:video, title: 'love world')
      expect(Video.search_by_title('love')).to eq([love_story, love_world])
    end
    it 'returns empty array if search term is a empty string' do 
      expect(Video.search_by_title('')).to eq([])
    end
  end

  describe '#recent_videos' do 
    it 'returns all videos if there is less than 6 videos' do
      action = Category.create(title: 'Action')
      old_movie = Fabricate(:video, category: action, created_at: 1.day.ago)
      new_movie = Fabricate(:video, category: action)
      expect(action.recent_videos).to eq([new_movie, old_movie])
    end
    it 'returns the first 6 videos if there is more than 6 videos in the category' do 
      action = Category.create(title: 'Action') 
      movie_1 = Fabricate(:video, category: action)
      movie_2 = Fabricate(:video, category: action)
      movie_3 = Fabricate(:video, category: action)
      movie_4 = Fabricate(:video, category: action)
      movie_5 = Fabricate(:video, category: action)
      movie_6 = Fabricate(:video, category: action)
      movie_7 = Fabricate(:video, category: action)
      expect(action.recent_videos).to eq([movie_7, movie_6, movie_5, movie_4, movie_3, movie_2])     
    end
  end
end

describe User do 
  it {should validate_presence_of(:name)}
  it {should validate_length_of(:name)}
  it {should validate_length_of(:password)}
  it {should validate_presence_of(:email)}
end




