class HomeController < ApplicationController
  def index
    @books = Book.order(created_at: :desc)
  end

  def add
    @book = Book.new
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


end
