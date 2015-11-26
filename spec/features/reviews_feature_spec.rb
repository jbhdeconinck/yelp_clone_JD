require 'rails_helper'

feature 'reviewing' do
  before {Restaurant.create name: 'KFC'}

  scenario 'allows user to leave a review using a form'do
    visit '/restaurants'
    click_link 'Review KFC'
    fill_in "Thoughts", with: "so so"
    select '3', from: 'Rating'
    click_button 'Leave Review'

    expect(current_path).to eq '/restaurants'
    expect(page).to have_content('so so')
  end

  scenario 'displays an average rating for all reviews' do
    sign_up(email: 'test@example.com', password: 'testtest', password_confirmation: 'testtest')
    visit '/restaurants'
    click_link 'Review KFC'
    leave_review('So so', '3')
    click_link 'Sign out'
    sign_up(email: 'test2@example.com', password: 'testtest2', password_confirmation: 'testtest2')
    visit '/restaurants'
    click_link 'Review KFC'
    leave_review('Great', '5')
    expect(page).to have_content('Average rating: 4')
  end


end
