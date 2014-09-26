class DashboardController < ApplicationController
  def index
    @post = current_user.posts.new(:scheduled_on => Time.now)
  end

  def login

  end
end
