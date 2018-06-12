class CommentsController < ApplicationController
  before_action :provide_movie, only: [:create, :destroy]
  before_action :authenticate_user!

  def create
    @comment = @movie.comments.build(comment_params.merge(user: current_user))
    if @comment.save
      redirect_to movie_path(@movie)
    else
      render "movies/show"
    end
  end

  def destroy
    @comment = @movie.comments.find(params[:id])
    @comment.destroy
    redirect_to movie_path(@movie), notice: "Comment was successfully deleted."
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def provide_movie
    @movie = Movie.find(params[:movie_id])
  end
end
