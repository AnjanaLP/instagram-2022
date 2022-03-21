class UsersController < ApplicationController
  before_action :set_user, only: [:show, :destroy, :followers, :following, :edit,
                                  :update, :destroy]
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy,
                                        :followers, :following]
  before_action :correct_user,   only: [:edit, :update, :destroy]

  def index
    @users = User.paginate(page: params[:page], per_page: 15)
  end

  def show
    @posts = @user.posts
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      reset_session
      log_in @user
      flash[:success] = "Welcome to Instagram!"
      redirect_to @user
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:success] = "Profile successfully updated"
      redirect_to @user
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  def destroy
    @user.delete
    log_out
    flash[:success] = "Account successfully deleted"
    redirect_to root_url, status: :see_other
  end

  def followers
    @title = "Followers"
    @users = @user.followers.paginate(page: params[:page], per_page: 15)
    render 'index'
  end

  def following
    @title = "Following"
    @users = @user.following.paginate(page: params[:page], per_page: 15)
    render 'index'
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :username, :password)
  end

  def set_user
    @user = User.friendly.find(params[:id])
  end

  def correct_user
    redirect_to(root_url) unless current_user?(@user)
  end
end
