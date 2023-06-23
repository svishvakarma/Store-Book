class BooksController < ApplicationController
  def index 
    @books = Book.all
  end

  def new 
    @book = Book.new
  end

  def create 
    @book = Book.new(book_params)
    if @book.save
      redirect_to @book
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @book = Book.find(params[:id])
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to @book
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @book = Book.find(params[:id])
  end

  private

  def book_params
    params.require(:book).permit(:name, :price, :quantity_available, :author_name, :isbn)
  end
end
