require 'rails_helper'

RSpec.describe "Basic", type: :feature do

  before do
    @book = create(:book)
    create(:highlight, content: "ABC", book: @book)
    create(:highlight, content: "DEF", book: @book)
  end

  it "move around pages" do
    visit '/admin'
    within('#page-title') { expect(page).to have_content('Books') }
    within('table tbody tr') do
      expect(page).to have_content(@book.title)
      expect(page).to have_content("2 highlights")
    end

    first('table tbody tr').click
    within('.main-content > header') { expect(page).to have_content('Book') }
    expect(first('textarea#highlight_summary').value).to include("ABC", "DEF")
  end
end
