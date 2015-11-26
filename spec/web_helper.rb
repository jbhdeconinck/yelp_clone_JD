def sign_in(email:, password:, password_confirmation:)
  visit('/sessions/new')
  fill_in :Email, with: email
  fill_in :Password, with: password
  fill_in('Password confirmation', with: password_confirmation)
  click_button 'Sign in'
end


def sign_up(email:, password:, password_confirmation:)
  visit('/')
  click_link('Sign up')
  fill_in('Email', with: email)
  fill_in('Password', with: password)
  fill_in('Password confirmation', with: password_confirmation)
  click_button('Sign up')
end

def leave_review(thoughts, rating)
  visit '/restaurants'
  click_link 'Review KFC'
  fill_in 'Thoughts', with: thoughts
  select rating, from: 'Rating'
  click_button 'Leave Review'
end
