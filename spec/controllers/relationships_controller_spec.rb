require 'spec_helper'

describe RelationshipsController do 
  describe "Get index" do 

    it_behaves_like "require_sign_in" do 
      let(:action){get :index}
    end

    context 'user is authenticated' do 

      before do 
        set_current_user
      end

      it 'sets @relationships as the array collection of all followed leader' do 
        bob = Fabricate(:user)
        jason = Fabricate(:user)
        relationship1 = Fabricate(:relationship, leader: bob, follower: sammy)
        relationship2 = Fabricate(:relationship, leader: jason, follower: sammy)
        get :index
        expect(assigns(:relationships)).to eq([relationship1, relationship2])
      end

      it 'render index template' do 
        get :index
        expect(response).to render_template :index
      end
    end
  end

  describe "Delete destroy" do 
    it "deletes the relationship if the current user is the follower" do 
      set_current_user
      bob = Fabricate(:user)
      relationship = Fabricate(:relationship, leader: bob, follower: sammy)
      delete :destroy, id: relationship
      expect(Relationship.count).to eq(0)
    end
    it "redirects to the people page" do 
      set_current_user
      bob = Fabricate(:user)
      relationship = Fabricate(:relationship, leader: bob, follower: sammy)
      delete :destroy, id: relationship
      expect(response).to redirect_to people_path
    end
    it "does not delete the relationship if the current user is not the follower" do 
      set_current_user
      bob = Fabricate(:user)
      relationship = Fabricate(:relationship, leader: bob)
      delete :destroy, id: relationship
      expect(Relationship.count).to eq(1)
    end
    it_behaves_like "require_sign_in" do 
      let(:action){delete :destroy}
    end
  end

  describe "POST Create" do 
    it_behaves_like "require_sign_in" do 
      let(:action){post :create}
    end
    it "creates a new relationship where the current user is following the user" do 
      set_current_user
      bob = Fabricate(:user)
      post :create, leader_id: bob.id
      expect(sammy.following_relationships.first.leader).to eq(bob)
    end
    it "does not create a relationship if the user is already follow the leader" do 
      set_current_user
      bob = Fabricate(:user)
      Fabricate(:relationship, leader: bob, follower: sammy)
      post :create, leader_id: bob.id
      expect(Relationship.count).to eq(1)
    end
    it "can not follow him/her self" do 
      set_current_user
      post :create, leader_id: sammy.id
      expect(Relationship.count).to eq(0)
    end
  end
end