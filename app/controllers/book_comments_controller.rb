class BookCommentsController < ApplicationController

  def create
    @book = Book.find(params[:book_id])
    @user = @book.user
    @book_comment = current_user.book_comments.new(book_comment_params)
    @book_comment.book_id = @book.id
    @book_comment.save
  end

  def destroy
    @book = Book.find(params[:book_id])
    @user = @book.user
    @book_comment = BookComment.find_by(user_id: current_user.id, book_id: params[:book_id])
    @book_comment.destroy
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end

  def correct_user
    @book_comment = current_user.comments.find_by(id: params[:id])
    unless @book_comment
    redirect_to request.referer
    end
  end

end


