require 'rails_helper'

def sign_up(user)
  visit '/'
  click_link 'Sign Up'
  fill_in 'Email', with: user.email
  fill_in 'Password', with: user.password
  fill_in 'Password confirmation', with: user.password_confirmation
  click_button 'Sign up'
end

def sign_in(user)
  visit '/'
  click_link 'Sign In'
  fill_in 'Email', with: user.email
  fill_in 'Password', with: user.password
  click_button 'Sign in'
end