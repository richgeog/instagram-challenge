require 'rails_helper'

feature 'commenting' do
  before(:each) do
    user_uploads_image
  end

  scenario 'allows a signed up user to leave a comment using a form' do
    expect(page).to have_selector('img')
    expect(page).to have_css('img[src*="test.jpg"]')
    expect(page).to have_content 'Sunset'
    expect(current_path).to eq '/photos'
    click_link 'Comment'
    fill_in "Thoughts", with: "Nice picture"
    click_button 'Leave Comment'
    expect(current_path).to eq '/photos'
    expect(page).to have_content('Nice picture')
  end

  scenario 'a non signed up user can not leave a comment' do
    expect(page).to have_selector('img')
    expect(page).to have_css('img[src*="test.jpg"]')
    expect(page).to have_content 'Sunset'
    expect(current_path).to eq '/photos'
    click_link 'Sign Out'
    visit '/'
    expect(page).to_not have_content 'Comment Sunset'
  end

  # scenario 'the user who created the comment can delete thier comment' do
  #   expect(page).to have_selector('img')
  #   expect(page).to have_css('img[src*="test.jpg"]')
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

  private

  def user_uploads_image
    user = build(:user)
    sign_up(user)
    click_link 'Add a photo'
    fill_in 'Title', with: 'Sunset'
    attach_file('photo[image]', 'spec/features/images/test.jpg')
    click_button 'Create Photo'
  end
end