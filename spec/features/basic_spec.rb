require 'rails_helper'

RSpec.describe "Basic", type: :feature do

  before do
    @book = create(:book)
  end

  it "move around pages" do
    visit '/admin'
    within('#page-title') { expect(page).to have_content('Books') }
    within('.collection-data tbody tr') { expect(page).to have_content(@book.title) }

    first('.collection-data tbody tr').click
    within('header.header') { expect(page).to have_content('Book') }
  end
end
