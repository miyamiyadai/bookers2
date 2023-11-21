class BooksController < ApplicationController
  before_action :is_matching_login_user, only: [:edit]
  
  def new
    @book = Book.new
  end
  
  def edit
    @book = Book.find(params[:id])
  end   
  
  def show
    @book = Book.find(params[:id])
    @user = User.find(current_user.id)
    @books = Book.all
  end  
  
  def index
    @user = current_user
    @books = Book.all
    @book = Book.new
  end   
  
  def create
    @user = User.find(current_user.id)
    @books = Book.all
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "create successfully"
      redirect_to book_path(@book.id)
    else
      render :index
    end   
  end 
  
  def update
    @book = Book.find(params[:id])
    @book.user_id = current_user.id
    if @book.update(book_params)
       flash[:notice] = "update successfully"
       redirect_to books_path(@book.id)  
    else
      render :edit
    end   
  end
  
  def destroy
    book = Book.find(params[:id])
    book.destroy 
    flash[:notice] = "delete successfully"
    redirect_to '/books' 
  end
  
  private
  def book_params
    params.require(:book).permit(:title, :body, :profile_image)  
  end
  
  def is_matching_login_user
    book = Book.find(params[:id])
    unless book.user.id == current_user.id
      redirect_to books_path
    end
  end
end
