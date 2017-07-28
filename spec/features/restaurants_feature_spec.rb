require 'rails_helper'

feature 'restaurants' do
  context 'no restaurants have been added' do
    scenario 'should display a prompt to add a restaurant' do
      visit '/restaurants'
      expect(page).to have_content 'No restaurants yet'
      expect(page).to have_link 'Add a restaurant'
    end
  end

  context 'restaurants have been added' do
    before do
      Restaurant.create(name: 'Byron')
    end

    scenario 'display restaurants' do
      visit '/restaurants'
      expect(page).to have_content('Byron')
      expect(page).not_to have_content('No restaurants yet')
    end
  end

  context 'creating restaurants' do
    scenario 'prompts user to fill out a form, then displays the new restaurant' do
      visit '/restaurants'
      click_link 'Add a restaurant'
      fill_in 'Name', with: 'Byron'
      fill_in 'Description', with: 'Amazing Burgers and Cream Soda'
      click_button 'Create Restaurant'
      expect(page).to have_content 'Byron'
      expect(current_path).to eq '/restaurants'
    end
  end

  context 'viewing restaurants' do

    let!(:byron){ Restaurant.create(name:'Byron', description: 'Amazing Burgers and Cream Soda') }

    scenario 'lets a user view a restaurant' do
      visit '/restaurants'
      click_link 'Byron'
      expect(page).to have_content 'Byron'
      expect(page).to have_content 'Amazing Burgers and Cream Soda'
      expect(current_path).to eq "/restaurants/#{byron.id}"
    end
  end

  context 'editing restaurants' do

    before { Restaurant.create name: 'Byron', description: 'Amazing Burgers and Cream Soda', id: 1 }
    scenario 'let a user edit a restaurant' do
      visit '/restaurants'
      click_link 'Edit Byron'
      fill_in 'Name', with: 'Byron'
      fill_in 'Description', with: 'Best burgers in town'
      click_button 'Update Restaurant'
      click_link 'Byron'
      expect(page).to have_content 'Byron'
      expect(page).to have_content 'Best burgers in town'
      expect(current_path).to eq '/restaurants/1'
    end
  end
end
