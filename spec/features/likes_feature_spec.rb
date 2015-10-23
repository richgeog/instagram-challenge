require 'rails_helper'

feature 'liking photos' do

  scenario 'a user can like an image, which increments the count', js: true do
    visit '/photos'
    click_link 'Add a photo'
    fill_in 'Title', with: 'sunset.jpg'
    attach_file('photo[image]', 'spec/features/images/test.jpg')
    click_button 'Create Photo'
    expect(page).to have_content 'sunset.jpg'
    expect(current_path).to eq '/photos'
    visit '/'
    click_link 'Like'
    expect(page).to have_content ('1 like')
  end
end
