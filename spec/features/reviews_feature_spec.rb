require 'rails_helper'

feature 'reviewing' do
  before { Restaurant.create name: 'Poppies' }

  scenario 'allows users to leave a review via a form' do
    visit '/restaurants'
    click_link 'Review Poppies'
    fill_in "Thoughts", with: "food coma"
    select '4', from: 'Rating'
    click_button 'Leave Review'

    expect(current_path).to eq '/restaurants'
    expect(page).to have_content('food coma')
  end
end
