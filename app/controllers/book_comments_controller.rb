class BookCommentsController < ApplicationController

  def create
    @book = Book.find(params[:book_id])
    @comment = current_user.book_comments.new(book_comment_params)
    @comment.book_id = @book.id
    @comment.save
    @book_comment = BookComment.new
    render :book_comments  #render先にjsファイルを指定
  end

  def destroy
    @book = Book.find(params[:book_id])
    @book_comment=BookComment.find_by(id: params[:id], book_id: params[:book_id])
    @book_comment.destroy
    @book_comment = BookComment.new #投稿が残らないようにするため
    render :book_comments  #render先にjsファイルを指定
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end

end