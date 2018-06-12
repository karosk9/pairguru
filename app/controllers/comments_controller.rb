class CommentsController < ApplicationController
  before_action :provide_movie, only: [:create, :destroy]

  def create
    @comment = Comment.new(comment_params.merge(movie: @movie).merge(user: current_user))
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
    params.require(:comment).permit(:body, :movie_id)
  end

  def provide_movie
    @movie = Movie.find(params[:movie_id])
  end
end
