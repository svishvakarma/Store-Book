class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_only, only: [:create, :update, :destroy]
  
  def index 
  @books = Book.all
  render json: @books.as_json(only: [:id, :name, :isbn, :stock_status], methods: [:stock_status])
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
    render json: @book
  end

  def edit
    @book = Book.find(params[:id])
  end
  
  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      render json: @book
    else
      render :edit, status: :unprocessable_entity
    end
  end
  
  def destroy
    @book = Book.find(params[:id])
    if @book.destroy
      render json: "Book has been deleted"
    end
  end
  
  private
  
  def book_params
    params.require(:book).permit(:name, :price, :quantity_available, :author_name, :isbn)
  end
  
  def admin_only
    unless current_user.admin?
      render json: { error: 'Unauthorized access' }, status: :unauthorized
    end
  end
end

