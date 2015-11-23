require 'rails_helper'

feature 'restaurants' do
  context 'no restauranst have been added' do
    scenario 'should display a prompt to add a restaurant' do
      visit '/restaurants'
      expect(page).to have_content 'No restaurants yet motherfuckers!'
      expect(page).to have_link 'Add a restaurant'
    end
  end
end
