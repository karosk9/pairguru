require "rails_helper"

RSpec.describe CommentsController, type: :controller do
  describe "Comments controller request specs" do
    login_user
    let!(:movie) { FactoryBot.create(:movie) }

    context "POST #create" do
      let!(:comment) { FactoryBot.create(:comment) }

      it "creates a new comment" do
        expect do
          post(:create,
               params: { movie_id: movie.id,
                         user_id: @user.id,
                         comment: FactoryBot.attributes_for(:comment) })
        end.to change(Comment, :count).by(1)
        expect(response).to redirect_to(movie)
      end
    end

    context "DELETE #destroy" do
      let!(:comment) { FactoryBot.create(:comment, movie_id: movie.id, user_id: @user.id) }
      it "should delete comment" do
        expect do
          delete :destroy, params: { id: comment.id, movie_id: movie }
        end.to change { movie.comments.count }.by(-1)
        expect(response).to redirect_to(movie)
        expect(flash[:notice]).to eq "Comment was successfully deleted."
      end
    end
  end
end
