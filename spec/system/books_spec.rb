require "rails_helper"

RSpec.describe "Books", type: :system do
  before { driven_by(:rack_test) }

  it "creates a book successfully and shows the created book" do
    visit home_add_path

    expect(page).to have_current_path(home_add_path)
    expect(page).to have_selector("h1", text: "Add a Book")
    expect(page).to have_selector("form")
    expect(page).to have_selector("label", text: "Title")
    expect(page).to have_field("book_title").or have_field("book[title]")

    fill_in "Title", with: "Mr Potter Aye"

    click_button "Create Book"

    expect(page).to have_content("Mr Potter Aye")
    expect(page).to have_content("Book was successfully added.")
  end

  it "fails to create a book with blank title and shows errors" do
    visit home_add_path

    expect(page).to have_current_path(home_add_path)
    expect(page).to have_selector("h1", text: "Add a Book")
    expect(page).to have_selector("form")
    expect(page).to have_selector("label", text: "Title")
    expect(page).to have_field("book_title").or have_field("book[title]")

    fill_in "Title", with: ""
    click_button "Create Book"

    expect(page).to have_text(/can't be blank|can’t be blank|title.*blank/i)
    expect(page).to have_content("Title can't be blank")
  end

  it "has an Author field and saves author" do
    visit home_add_path
    expect(page).to have_selector("h1", text: "Add a Book")
  
    expect(page).to have_field("book_author")
  
    fill_in "book_title",  with: "Test with Author"
    fill_in "book_author", with: "Jackson Ward!"
  
    click_button "Create Book"
    expect(page).to have_content("Book was successfully added.")
    expect(Book.last.author).to eq("Jackson Ward!")
  end
  

  it "has a Price field and saves price" do
    visit home_add_path
    expect(page).to have_selector("h1", text: "Add a Book")
  
    expect(page).to have_field("book_price")
  
    fill_in "book_title", with: "Test with Price"
    fill_in "book_price", with: "12.22"
  
    click_button "Create Book"
    expect(page).to have_content("Book was successfully added.")
    expect(Book.last.price.to_f).to be_within(0.001).of(12.22)
  end
  

  it "has a Published date field and saves published date" do
    visit home_add_path
    expect(page).to have_selector("h1", text: "Add a Book")
  
    expect(page).to have_select("book_publish_date_1i")
    expect(page).to have_select("book_publish_date_2i")
    expect(page).to have_select("book_publish_date_3i")
  
    fill_in "book_title", with: "Test with Date"
  
    select "2004", from: "book_publish_date_1i"
    select "April",  from: "book_publish_date_2i"
    select "12",   from: "book_publish_date_3i"
  
    click_button "Create Book"
    expect(page).to have_content("Book was successfully added.")
    expect(Book.last.publish_date&.to_s).to include("2004-04-12")
  end
end
