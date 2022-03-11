class PagesController < ApplicationController
  def home
    if logged_in?
      @feed_posts = current_user.feed
      @comment = current_user.comments.build
    else
      render 'sessions/new'
    end
  end
end
