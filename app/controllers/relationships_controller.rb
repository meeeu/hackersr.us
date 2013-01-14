class RelationshipsController < ApplicationController
  before_filter :authenticate

  def create
    @node = Node.find(params[:relationship][:followed_id])
    current_user.follow!(@node)
    redirect_to @node
  end

  def destroy
    @node = Relationship.find(params[:id]).followed
    current_user.unfollow!(@node)
    redirect_to @node
  end
end
