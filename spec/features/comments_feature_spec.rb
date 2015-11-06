require 'rails_helper'

feature 'commenting' do

  scenario 'allows a signed up user to leave a commenting using a form' do
    user = build(:user)
    sign_up(user)
    click_link 'Add a photo'
    fill_in 'Title', with: 'Sunset'
    attach_file('photo[image]', 'spec/features/images/test.jpg')
    click_button 'Create Photo'
    expect(page).to have_content 'Sunset'
    expect(current_path).to eq '/photos'
    click_link 'Comment Sunset'
    fill_in "Thoughts", with: "Nice picture"
    click_button 'Leave Comment'
    expect(current_path).to eq '/photos'
    expect(page).to have_content('Nice picture')
  end

  scenario 'a non signed up user can not leave a comment' do
    user = build(:user)
    sign_up(user)
    click_link 'Add a photo'
    fill_in 'Title', with: 'Sunset'
    attach_file('photo[image]', 'spec/features/images/test.jpg')
    click_button 'Create Photo'
    expect(page).to have_content 'Sunset'
    expect(current_path).to eq '/photos'
    click_link 'Sign out'
    visit '/'
    expect(page).to_not have_content 'Comment Sunset'
  end

  # scenario 'the user who created the comment can delete thier comment' do
  #   user = build(:user)
  #   sign_up(user)
  #   click_link 'Add a photo'
  #   fill_in 'Title', with: 'Sunset'
  #   attach_file('photo[image]', 'spec/features/images/test.jpg')
  #   click_button 'Create Photo'
  #   expect(page).to have_content 'Sunset'
  #   expect(current_path).to eq '/photos'
  #   click_link 'Comment Sunset'
  #   fill_in "Thoughts", with: "Nice picture"
  #   click_button 'Leave Comment'
  #   expect(current_path).to eq '/photos'
  #   expect(page).to have_content('Nice picture')
  #   click_link 'Delete Nice picture'
  #   expect(page).to have_content 'Comment deleted successfully'
  #   expect(page).to_not have_content 'Nice picture'
  #   expect(current_path).to eq '/photos'
  # end
end