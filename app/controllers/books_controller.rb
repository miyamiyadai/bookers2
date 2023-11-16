class BooksController < ApplicationController
  def new
  end
  
  private
  def book_params
    params.require(:book).permit(:title, :body, :image)  end
end
