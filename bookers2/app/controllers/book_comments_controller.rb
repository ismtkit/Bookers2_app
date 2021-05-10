class BookCommentsController < ApplicationController

  def create
    @book = Book.find(params[:book_id])
    @comment = current_user.book_comments.build(params.require(:book_comment).permit(:comment))
    @comment.book_id = @book.id
    if @comment.save
       @book_comment = BookComment.new
    else
      @book = Book.find(params[:book_id])
      @book_new = Book.new
      @user = @book.user
      @book_comment = @comment
      render 'error'
    end
  end

  def destroy
     @book = Book.find(params[:book_id])
    BookComment.find_by(id: params[:id], book_id: params[:book_id]).destroy
     @book_comment = BookComment.new
  end


end
