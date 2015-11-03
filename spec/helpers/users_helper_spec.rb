require 'rails_helper'

def sign_up
  visit '/'
  click_link 'Sign up'
  fill_in 'Email', with: user1.email
  fill_in 'Password', with: user1.password
  fill_in 'Password_confirmation', with: user1.password_confirmation
  click_button 'Sign up'
end

def sign_in
  visit '/'
  click_link 'Sign in'
  fill_in 'Email', with: user1.email
  fill_in 'Password', with: user1.password
  click_button 'Sign in'
end