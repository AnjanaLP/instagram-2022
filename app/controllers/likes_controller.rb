class LikesController < ApplicationController
  before_action :logged_in_user, only: [:create]

  def create
    @post = Post.find(params[:post_id])
    @like = @post.likes.build(user_id: current_user.id)
    if @like.save
      redirect_to @post
    else
      flash.now[:danger] = "You have already liked this post"
      render 'posts/show', status: :unprocessable_entity
    end
  end
end
