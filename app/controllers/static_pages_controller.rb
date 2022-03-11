class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @feed_posts = current_user.feed
      @comment = current_user.comments.build
    else
      redirect_to signup_path
    end
  end
end
