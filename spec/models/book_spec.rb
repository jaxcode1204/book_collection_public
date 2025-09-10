require "rails_helper"

RSpec.describe Book, type: :model do
  describe "validations" do
    it "is valid with a title" do
      book = Book.new(title: "Clean Code")
      expect(book).to be_valid
    end

    it "is invalid without a title" do
      book = Book.new(title: nil)
      expect(book).not_to be_valid
      expect(book.errors[:title]).to include("can't be blank").or include("can’t be blank")
    end
  end

 
  describe "new attributes (author, price, publish_date)" do
    it "responds to :author" do
      expect(Book.new).to respond_to(:author) 
    end

    it "responds to :price" do
      expect(Book.new).to respond_to(:price)
    end

    it "responds to :publish_date" do
      expect(Book.new).to respond_to(:publish_date)
    end
  end
end
