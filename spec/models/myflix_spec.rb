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





