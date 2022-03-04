class PostsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def show
    @post = Post.find(params[:id])
    @comment = @post.comments.build
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
      flash[:success] = "Your post has been updated"
      redirect_to current_user
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
    flash[:success] = "Your post has been deleted"
    redirect_to current_user, status: :see_other
  end

  private

  def post_params
    params.require(:post).permit(:caption, :image)
  end

  def correct_user
    @post = current_user.posts.find_by(id: params[:id])
    redirect_to root_url if @post.nil?
  end
end
