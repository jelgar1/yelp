require 'rails_helper'

feature 'restaurants' do
  context 'no restaurants have been added' do
    scenario 'should display a prompt to ad a new restaurant' do
      visit '/restaurants'
      expect(page).to have_content 'No restaurants yet'
      expect(page).to have_link 'Add a restaurant'
    end
  end

  context 'restaurants have been added' do
    before do
      Restaurant.create(name: 'Hawksmoor')
    end

    scenario 'display restaurants' do
      visit '/restaurants'
      expect(page).to have_content('Hawksmoor')
      expect(page).not_to have_content('No restaurants yet')
    end
  end

  context 'creating restaurants' do
    scenario 'prompts user to fill out a form, then displays the new restaurant' do
      sign_in
      visit '/restaurants'
      click_link 'Add a restaurant'
      fill_in 'Name', with: 'Hawksmoor'
      click_button 'Create Restaurant'
      expect(page).to have_content 'Hawksmoor'
      expect(current_path).to eq '/restaurants'
    end

    context 'an invalid restaurant' do
      it 'does not let you submit a name that is too short' do
        sign_in
        visit '/restaurants'
        click_link 'Add a restaurant'
        fill_in 'Name', with: 'kf'
        click_button 'Create Restaurant'
        expect(page).not_to have_css 'h2', text: 'kf'
        expect(page).to have_content 'error'
      end
    end
  end

  context 'viewing restaurants' do
    let!(:kfc){Restaurant.create(name:'KFC')}

    scenario 'lets a user view a restaurant' do
      visit '/restaurants'
      click_link 'KFC'
      expect(page).to have_content 'KFC'
      expect(current_path).to eq "/restaurants/#{kfc.id}"
    end
  end

  context 'editing restaurants' do

    scenario 'let a user edit a restaurant' do
      sign_in
      create_restaurant
      visit '/restaurants'
      click_link 'Edit Hawksmoor'
      fill_in 'Name', with: 'Hawksmoor Steak'
      click_button 'Update Restaurant'
      expect(page).to have_content 'Hawksmoor Steak'
      expect(current_path).to eq '/restaurants'
    end
  end

  context 'deleting restaurants' do

    scenario 'removes a restaurant when a user clicks a delete link' do
      sign_in
      create_restaurant
      visit '/restaurants'
      click_link 'Delete Hawksmoor'
      expect(page).not_to have_content 'Hawksmoor'
      expect(page).to have_content 'Restaurant deleted successfully'
    end

  end

  scenario 'won\'t allow a user to remove a restaurant they didn\'t create' do
    sign_in
    visit '/restaurants'
    click_link 'Add a restaurant'
    fill_in 'Name', with: 'Dishoom'
    click_button 'Create Restaurant'
    click_link 'Sign out'
    sign_in2
    visit '/restaurants'
    expect(page).not_to have_content 'Delete Dishoom'
  end
end
