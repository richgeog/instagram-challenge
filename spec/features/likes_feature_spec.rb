require 'rails_helper'

feature 'liking photos' do

  scenario 'a user can like an image, which increments the count', js: true do
    user = build(:user)
    sign_up(user)
    visit '/photos'
    click_link 'Add a photo'
    fill_in 'Title', with: 'Sunset'
    attach_file('photo[image]', 'spec/features/images/test.jpg')
    click_button 'Create Photo'
    expect(page).to have_selector('img')
    expect(page).to have_css('img[src*="test.jpg"]')
    expect(page).to have_content 'Sunset'
    expect(current_path).to eq '/photos'
    visit '/'
    click_link 'Like'
    expect(page).to have_content('1 like')
  end
end
