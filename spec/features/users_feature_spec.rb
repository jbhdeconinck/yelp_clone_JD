require 'rails_helper'

feature "User can sign in and out" do
    context "user not signed in and on the homepage" do
      it "should see a 'sign in' link and a 'sign up' link" do
        visit('/')
        expect(page).to have_link('Sign in')
        expect(page).to have_link('Sign up')
      end

      it "should not see 'sign out' link" do
        visit('/')
        expect(page).not_to have_link('Sign out')
      end
    end

    context "user signed in on the homepage" do
      before do
        sign_up(email: 'test@example.com', password: 'testtest', password_confirmation: 'testtest')
      end

      it "should see 'sign out' link" do
        visit('/')
        expect(page).to have_link('Sign out')
      end

      it "should not see a 'sign in' link and a 'sign up' link" do
        visit('/')
        expect(page).not_to have_link('Sign in')
        expect(page).not_to have_link('Sign up')
      end
    end
  end

feature 'user must be logged in to create restaurants' do
  it "should not have Create Restaurant link" do
    visit('/')
    click_link 'Add a restaurant'
    expect(page).not_to have_button 'Create Restaurant'
  end
end

feature 'user can only delete restaurant it created' do
  it "cannot delete restaurant it did not create" do
    sign_up(email: 'test@example.com', password: 'testtest', password_confirmation: 'testtest')
    visit '/restaurants'
    click_link 'Add a restaurant'
    fill_in 'Name', with: 'KFC'
    click_button 'Create Restaurant'
    click_link 'Sign out'
    sign_up(email: 'test2@example.com', password: 'test2test2', password_confirmation: 'test2test2')
    visit '/restaurants'
    click_link 'Delete KFC'
    expect(page).to have_content("Restaurant cannot be deleted")
  end
end

feature 'user can only edit restaurant it created' do
  it "cannot edit restaurant it did not create" do
    sign_up(email: 'test@example.com', password: 'testtest', password_confirmation: 'testtest')
    visit '/restaurants'
    click_link 'Add a restaurant'
    fill_in 'Name', with: 'KFC'
    click_button 'Create Restaurant'
    click_link 'Sign out'
    sign_up(email: 'test2@example.com', password: 'test2test2', password_confirmation: 'test2test2')
    visit '/restaurants'
    click_link 'Edit KFC'
    expect(page).to have_content("Restaurant cannot be edited")
  end
end

feature 'user can only leave one review per restaurant' do

  before do
    Restaurant.create(name: 'KFC')
  end

  it "cannot review restaurant already reviewed" do
    sign_up(email: 'test@example.com', password: 'testtest', password_confirmation: 'testtest')
    visit '/restaurants'
    click_link 'Review KFC'
    fill_in "Thoughts", with: "so so"
    select '3', from: 'Rating'
    click_button 'Leave Review'
    click_link 'Review KFC'
    fill_in "Thoughts", with: "so so"
    select '3', from: 'Rating'
    click_button 'Leave Review'
    expect(page).to have_content("Restaurant already reviewed")
  end
end

feature 'user can delete reviews' do
  before do
    Restaurant.create(name: 'KFC')
  end

  context "can delete his own reviews" do
    it "can delete reviews it created" do
      sign_up(email: 'test@example.com', password: 'testtest', password_confirmation: 'testtest')
      visit '/restaurants'
      click_link 'Review KFC'
      fill_in "Thoughts", with: "so so"
      select '3', from: 'Rating'
      click_button 'Leave Review'
      click_link 'Delete Review'
      expect(page).not_to have_content 'so so'
      expect(page).to have_content 'Review deleted successfully'
    end
  end

  context "cannot delete other users' reviews" do
    it "cannot delete reviews it did not create" do
      sign_up(email: 'test@example.com', password: 'testtest', password_confirmation: 'testtest')
      visit '/restaurants'
      click_link 'Review KFC'
      fill_in "Thoughts", with: "so so"
      select '3', from: 'Rating'
      click_button 'Leave Review'
      click_link 'Sign out'
      sign_up(email: 'test2@example.com', password: 'test2test2', password_confirmation: 'test2test2')
      visit '/restaurants'
      click_link 'Delete Review'
      expect(page).to have_content("Review cannot be deleted")
    end
  end

end
