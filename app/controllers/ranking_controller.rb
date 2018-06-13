class RankingController < ApplicationController

  def index
    @users = User.top_commenters
  end
end
