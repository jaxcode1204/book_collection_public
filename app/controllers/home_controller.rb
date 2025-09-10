class HomeController < ApplicationController
  def index
    @books = Book.order(created_at: :desc)
  end
  
  def add
    if request.post?
      @book = Book.new(book_params)
      if @book.save
         flash[:notice] = "Book was successfully added."
         redirect_to home_index_path
      else
          flash.now[:alert] = @book.errors.full_messages.to_sentence
          render :add, status: :unprocessable_content
      end
    else
      @book = Book.new
    end
  end

  def delete
    @book = Book.find(params[:id])
  end

  def details
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find_by(id: params[:id])
  end

  private

  def book_params
    params.require(:book).permit(:title, :price, :author, :publish_date)
  end
end
