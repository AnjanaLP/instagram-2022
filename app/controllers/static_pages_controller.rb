class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @feed_posts = current_user.feed
    else
      redirect_to signup_path
    end
  end
end
