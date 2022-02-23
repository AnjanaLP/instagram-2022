class PostsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :destroy]

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    @post.image.attach(params[:post][:image])
    if @post.save
      flash[:success] = "Your post has been shared"
      redirect_to current_user
    else
      render 'new', status: :unprocessable_entity
    end
  end

  private

  def post_params
    params.require(:post).permit(:caption, :image)
  end
end
