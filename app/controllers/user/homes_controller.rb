class User::HomesController < ApplicationController
  before_action :set_user, only: [:likes]
  def
    top
  end
  
  def likes
    likes = Like.where(user_id: @user.id).pluck(:post_id)
    @like_posts = Post.find(likes)
  end

private
  def set_user
    @user = User.find(params[:id])
  end


end
