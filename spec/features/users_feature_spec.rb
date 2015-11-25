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

feature 'user can only delete/edit restaurant it created' do
  it "cannot delete restaurant it did not create" do
    sign_up(email: 'test@example.com', password: 'testtest', password_confirmation: 'testtest')
    visit '/restaurants'
    click_link 'Add a restaurant'
    fill_in 'Name', with: 'KFC'
    click_button 'Create Restaurant'
    sign_up(email: 'test2@example.com', password: 'test2test2', password_confirmation: 'test2test2')
    visit '/restaurants'
    click_link 'Edit KFC'
    expect(page).to have_content("Restaurant cannot be deleted")
  end
end
