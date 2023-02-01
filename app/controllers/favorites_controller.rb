class FavoritesController < ApplicationController

  def create
    @book_favorite = Favorite.new(user_id: current_user.id, book_id: params[:book_id])
    @book_favorite.save
    redirect_to book_path(params[:book_id])
  end

  def destroy
    @book_favorite = Favorite.find_by(user_id: current_user.id, book_id: params[:book_id])
    @book_favorite.destroy
    redirect_to book_path(params[:book_id])
  end
end
