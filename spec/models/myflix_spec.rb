require 'spec_helper'

describe Video do #'describe' is the syntax for test, and the Video is the model name matchs the model we are going to test.

  it 'save itself' do # 'it' is the saved word
    #1.  set up the stage(data)
    video = Video.new(title: 'Mission Impossible 3', description: 'Very cool movie')

    #2.  perform a action
    video.save

    #3.  verify the result
    Video.first.should == video
    expect(Video.first).to eq(video)
    Video.first.should eq(video)
  end

  #shoulda-matchers gem can test common rails functionality
  it {should validate_presence_of(:title)}
  it {should validate_presence_of(:description)}
  it {should belong_to(:category)}

  describe '#search_by_tile' do 
    it 'returns empty array if there is no match' do 
      Video.create(title: 'interstella', description: 'a science fiction movie')
      expect(Video.search_by_title("family")).to eq([])
    end
    it 'returns an array of one video if there is a complete match' do 
      interstella = Video.create(title: 'Interstella', description: 'a science fiction movie')
      expect(Video.search_by_title('Interstella')).to eq([interstella])
    end
    it 'returns an array of one video if there is a partial match' do 
      love_world = Video.create(title: 'love world', description: 'a romantic movie')
      expect(Video.search_by_title('love')).to eq([love_world])
    end
    it 'returns an array of videos if there is multiple matchs' do 
      love_world = Video.create(title: 'love world', description: 'a romantic movie')
      love_story = Video.create(title: 'love story', description: 'a romantic movie')
      expect(Video.search_by_title('love')).to eq([love_world, love_story])
    end
    it 'returns empty array if search term is a empty string' do 
      expect(Video.search_by_title('')).to eq([])
    end
  end

  describe '#recent_videos' do 
    it 'returns all videos if there is less than 6 videos' do
      action = Category.create(title: 'Action')
      movie_1 = Video.create(title: 'movie 1', description: 'the old movie', category: action, created_at: 1.day.ago)
      movie_2 = Video.create(title: 'movie 2', description: 'the new movie', category: action)
      expect(action.recent_videos).to eq([movie_2, movie_1])
    end
    it 'returns the first 6 videos if there is more than 6 videos in the category' do 
      action = Category.create(title: 'Action') 
      movie_1 = Video.create(title: 'movie 1', description: 'the old movie', category: action)
      movie_2 = Video.create(title: 'movie 2', description: 'the old movie', category: action)
      movie_3 = Video.create(title: 'movie 3', description: 'the old movie', category: action)
      movie_4 = Video.create(title: 'movie 4', description: 'the old movie', category: action)
      movie_5 = Video.create(title: 'movie 5', description: 'the old movie', category: action)
      movie_6 = Video.create(title: 'movie 6', description: 'the old movie', category: action)
      movie_7 = Video.create(title: 'movie 7', description: 'the old movie', category: action)
      expect(action.recent_videos).to eq([movie_7, movie_6, movie_5, movie_4, movie_3, movie_2])     
    end
  end

end

describe Category do 

  it 'saves it self' do
    action = Category.create(title: 'Action')
    expect(Category.first).to eq(action)
  end

  it 'has_many movies' do
    kids = Category.create(title: 'Kids')
    how_to_train_dragon = Video.create(title: 'How to train dragon', description: 'fun movie for kids', category: kids)
    shrek = Video.create(title: 'Shrek', description: 'fun movie for kids', category: kids)
    expect(kids.videos).to include(shrek, how_to_train_dragon)
  end

end





