require 'spec_helper'

describe QueueItemsController do 
  describe "GET index" do 
    it 'sets @queue_items' do 
      alice = Fabricate(:user, name: 'alice')
      session[:user_id] = alice.id
      item1 = Fabricate(:queue_item, user: alice)
      item2 = Fabricate(:queue_item, user: alice)
      get 'index'
      expect(assigns(:queue_items)).to match_array([item1, item2])
    end
    it 'redirect_to sign_in page for unauthenticated user' do 
      session[:user_id] = nil
      item1 = Fabricate(:queue_item)
      item2 = Fabricate(:queue_item)
      get 'index'
      expect(response).to redirect_to front_videos_path
    end
  end  

  describe "POST create" do 
    context 'user is authenticated' do 
      let(:sammy){Fabricate(:user)}
      before do 
        session[:user_id] = sammy.id
      end
      it 'redirect_to queue_items_path if user is signed in' do
        post 'create'
        expect(response).to redirect_to queue_items_path 
      end
      it 'create a queue item' do 
        post 'create', video_id: Fabricate(:video).id
        expect(QueueItem.count).to eq(1)
      end
      it 'create a queue item accossiated with video' do 
        inception = Fabricate(:video, title: 'inception')
        post 'create', video_id: inception.id
        expect(QueueItem.last.video).to eq(inception)
      end
      it 'create a queue item accossiated with current user' do 
        post 'create'
        expect(QueueItem.last.user).to eq(sammy)
      end
      it 'place the queue item in the last position' do 
        inception = Fabricate(:video, title: 'inception')
        Fabricate(:queue_item, video: inception, user: sammy)
        ted = Fabricate(:video)
        post 'create', video_id: ted.id
        ted_queue_item = QueueItem.where(video_id: ted.id, user_id: sammy.id).first
        expect(ted_queue_item.position).to eq(2)
      end
      it 'do not create the queue item if the video is already in the queue' do 
        inception = Fabricate(:video, title: 'inception')
        Fabricate(:queue_item, video: inception, user: sammy)
        post 'create', video_id: inception.id
        expect(QueueItem.count).to eq(1)
      end
    end
    it 'redirect_to root_path if the user is not signed in' do 
      session[:user_id] = nil
      post 'create', video_id: Fabricate(:video).id
      expect(response).to redirect_to front_videos_path
    end
  end

  describe "DELETE destroy" do 
    context 'with authenticated user' do 
      let(:sammy){Fabricate(:user)}
      before do 
        session[:user_id] = sammy.id
      end

      it "redirect to queue_items_path" do 
        inception_queue = Fabricate(:queue_item, video: Fabricate(:video), user: sammy)
        delete "destroy", id: inception_queue.id
        expect(response).to redirect_to queue_items_path
      end

      it "delete the queue item" do 
        inception_queue = Fabricate(:queue_item, video: Fabricate(:video), user: sammy)
        delete "destroy", id: inception_queue.id
        expect(QueueItem.count).to eq(0)
      end

      it "shift the position of the queue items that are after the deleted item" do 
        item1 = Fabricate(:queue_item, video: Fabricate(:video), user: sammy, position: 1)
        item2 = Fabricate(:queue_item, video: Fabricate(:video), user: sammy, position: 2)
        item3 = Fabricate(:queue_item, video: Fabricate(:video), user: sammy, position: 3)
        item4 = Fabricate(:queue_item, video: Fabricate(:video), user: sammy, position: 4)
        delete "destroy", id: item2.id
        expect(QueueItem.last.position).to eq(3)
      end

      it 'normalize the remaining queue_item' do 
        item1 = Fabricate(:queue_item, user: sammy, position: 1)
        item2 = Fabricate(:queue_item, user: sammy, position: 2)
        delete "destroy", id: item1.id
        expect(item2.reload.position).to eq(1)
      end
    end

    it 'redirect to front_videos_path if user is not authenticated' do 
      session[:user_id] = nil
      delete 'destroy', id: Fabricate(:queue_item).id
      expect(response).to redirect_to front_videos_path
    end
  end

  describe 'POST update_position' do 

    context 'with valid input' do
      let(:sammy){Fabricate(:user, name: 'sammy')} 
      let(:item1){Fabricate(:queue_item, user: sammy, position: 1)}
      let(:item2){Fabricate(:queue_item, user: sammy, position: 2)}
      before do 
        session[:user_id] = sammy.id
      end

      it 'update the position' do   
        post 'update_position', queue_item: [{id: item1.id, position: 2}, {id: item2.id, position: 1}]
        expect(item1.reload.position).to eq(2)
        expect(sammy.queue_items.map(&:position)).to eq([1,2])
      end

      it 'order the items by position' do 
        post 'update_position', queue_item: [{id: item1.id, position: 2}, {id: item2.id, position: 1}]
        expect(sammy.queue_items).to eq([item2.reload, item1.reload])
      end

      it 'redirect to queue_items_path' do 
        post 'update_position', queue_item: [{id: item1.id, position: 2}, {id: item2.id, position: 1}]
        expect(response).to redirect_to queue_items_path
      end

      it 'normalize the position' do 
        post 'update_position', queue_item: [{id: item1.id, position: 3}, {id: item2.id, position: 2}]
        expect(sammy.queue_items.map(&:position)).to eq([1,2])
      end
    end

    context 'with invalid input' do 
      let(:sammy){Fabricate(:user, name: 'sammy')} 
      let(:item1){Fabricate(:queue_item, user: sammy, position: 1)}
      let(:item2){Fabricate(:queue_item, user: sammy, position: 2)}
      before do 
        session[:user_id] = sammy.id
      end

      it 'do not update the position' do 
        post 'update_position', queue_item: [{id: item1.id, position: 3.4}, {id: item2.id, position: 1}]
        expect(sammy.queue_items).to eq([item1, item2])
      end

      it 'raise an flash' do 
        post 'update_position', queue_item: [{id: item1.id, position: 3.4}, {id: item2.id, position: 1}]
        expect(flash[:danger]).to be_present
      end

      it 'redirect to queue_items_path' do
        post 'update_position', queue_item: [{id: item1.id, position: 3.4}, {id: item2.id, position: 1}]
        expect(response).to redirect_to queue_items_path
      end

    end

    context 'with unauthenticated user' do 
      before do 
        session[:user_id] = nil
      end

      it 'redirect_to front_videos_path' do 
        post 'update_position'
        expect(response).to redirect_to front_videos_path
      end
    end

    context 'the queue_item is not belongs to the current_user' do 
      let(:sammy){Fabricate(:user)}
      let(:hacker){Fabricate(:user)}
      let(:item1){Fabricate(:queue_item, user: sammy, position: 1)}
      let(:item2){Fabricate(:queue_item, user: hacker, position: 2)}
      before do 
        session[:user_id] = hacker.id
      end
      it 'do not update the position' do
        post 'update_position', queue_item: [{id: item1.id, position: 2}, {id: item2.id, position: 1}]
        expect(item1.reload.position).to eq(1)
      end
      it 'redirect_to queue_items_path' do 
        post 'update_position', queue_item: [{id: item1.id, position: 2}, {id: item2.id, position: 1}]
        expect(response).to redirect_to queue_items_path
      end
    end
  end
end


































