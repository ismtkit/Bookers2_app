class UsersController < ApplicationController
  before_action :screen_user, only: [:edit, :update]

  def index
    @users = User.all
    @user = current_user
    @book = Book.new
  end

  def show
     @user = User.find(params[:id])
     @book_new = Book.new
     @books_user = @user.books.order("created_at DESC")
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
   if @user.update(user_params)
     redirect_to user_path(@user.id),notice: 'You have updated user successfully.'
   else
     render :edit
   end
  end

  private
  def screen_user
    @user = User.find(params[:id])
   if current_user.id != @user.id
     redirect_to user_path(current_user)
   end
  end

  def user_params
      params.require(:user).permit(:name, :profile_image, :introduction,)
  end

end
