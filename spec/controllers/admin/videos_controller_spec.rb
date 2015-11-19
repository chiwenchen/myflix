require 'spec_helper'

describe Admin::VideosController do 
  describe "GET new" do 
    it "sets @video to a new instance of Video" do
      set_current_admin
      get :new
      expect(assigns(:video)).to be_instance_of Video
      expect(assigns(:video)).to be_new_record
    end
    it_behaves_like 'require_admin' do
        let(:action){get :new}
      end
  end

  describe "POST create" do

    context "with valid input" do
      it "redirect back to the :new_admin_video_path" do
        set_current_admin
        category = Fabricate(:category)
        post :create, video: Fabricate.attributes_for(:video, category: category)
        expect(response).to redirect_to new_admin_video_path
      end
      it "create a new Video in database" do
        set_current_admin
        category = Fabricate(:category)
        post :create, video: Fabricate.attributes_for(:video, category: category)
        expect(Video.count).to eq(1)
      end  
      it "sets the flash[:success] " do
        set_current_admin
        category = Fabricate(:category)
        post :create, video: Fabricate.attributes_for(:video, category: category)
        expect(flash[:success]).to be_present
      end
      it_behaves_like 'require_admin' do
        let(:action){post :create}
      end
    end

    context "with invalid input" do 
      before do
        set_current_admin
        category = Fabricate(:category)
        post :create, video: Fabricate.attributes_for(:video, title: nil, category: category) 
      end

      it "does not create a video" do
        expect(Video.count).to eq(0)
      end
      it "render the new template" do   
        expect(response).to render_template :new
      end    
      it "keeps the entered column" do
        expect(assigns(:video)).to be_present 
      end
    end

  end

end

