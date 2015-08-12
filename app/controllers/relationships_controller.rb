class RelationshipsController < ApplicationController
  before_action :require_user

  def index 
    @relationships = current_user.following_relationships
  end 

  def create
    leader = User.find(params[:leader_id])
    Relationship.create(leader: leader, follower: current_user) unless current_user.followed?(leader) || current_user == leader
    redirect_to people_path
  end

  def destroy
    relationship = Relationship.find(params[:id])
    relationship.delete if relationship.follower == current_user
    redirect_to people_path
  end

end