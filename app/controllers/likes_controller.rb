class LikesController < ApplicationController
  before_action :logged_in_user, only: [:create]

  def create
    @post = Post.find(params[:post_id])
    @like = @post.likes.build
    @like.user_id = current_user.id
    if @like.save
      redirect_to @post
    end
  end
end
