class BooksController < ApplicationController
    before_action :set_book, only: [:update, :destroy]

    def index
      @books = Book.order(:title)
    end

    def create
      @book = Book.new(book_params)
      if @book.save
        redirect_to root_path, notice: "Book was successfully added."
      else
        flash.now[:alert]= @book.errors.full_messages.to_sentence
        render "home/add", status: :unprocessable_entity
      end
    end

    def update
      if @book.update(book_params)
        redirect_to root_path, notice: "Book was successfully updated."
      else
        flash.now[:alert] = @book.errors.full_messages.to_sentence
        render "home/update", status: :unprocessable_entity
      end
    end
    
    def destroy
      @book.destroy
      redirect_to root_path, notice: "Book was successfully destroyed."
    end

    
      private
    
      def set_book
        @book = Book.find(params[:id])
      end

      def book_params
        params.require(:book).permit(:title)
      end
end
