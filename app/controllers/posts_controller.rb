class PostsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :edit, :update]
  before_action :correct_user, only: [:edit, :update]

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = current_user.posts.build
  end

  def edit
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

  def update
    if @post.update(post_params)
      flash[:success] = "Post successfully updated"
      redirect_to @post.user
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  private

  def post_params
    params.require(:post).permit(:caption, :image)
  end

  def correct_user
    @post = Post.find(params[:id])
    redirect_to(root_url) unless current_user?(@post.user)
  end
end
