require 'rails_helper'

feature 'endorsing reviews' do
  # let(:user) { FactoryGirl.build(:user) }
  # let(:user2) { FactoryGirl.build(:user2) }

  before do
    kfc = Restaurant.create(name: 'KFC')
    kfc.reviews.create(rating: 3, thoughts: 'It was crap')
  end

  scenario 'a user can endorse a review, which updates the review endorsement count', js: true do
    visit '/restaurants'
    click_link 'Endorse'
    expect(page).to have_content('1 endorsement')
  end

end
