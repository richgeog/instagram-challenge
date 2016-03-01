require 'rails_helper'

feature 'photos' do

  context 'no photos have been added' do
    scenario 'should display a prompt to add a photo' do
      user = build(:user)
      sign_up(user)
      visit '/photos'
      expect(page).to have_content 'No photos added!'
      expect(page). to have_link 'Add a photo'
    end
  end

  context 'photos have been added' do
    before(:each) do
      user_uploads_image
    end

    scenario 'displays all photos that have been uploaded' do
      expect(page).to have_content('Sunset')
      expect(page).not_to have_content('No photos added')
      click_link 'Sign Out'
      user = build(:userbob)
      sign_up(user)
      visit '/photos/new'
      fill_in 'Title', with: 'Sunrise'
      attach_file('photo[image]', 'spec/features/images/test.jpg')
      click_button 'Create Photo'
      expect(page).to have_selector('img')
      expect(page).to have_css('img[src*="test.jpg"]')
      expect(page).to have_content('Sunset')
      expect(page).to have_content('Sunrise')
      expect(page).not_to have_content('No photos added')
    end
  end

  context 'adding photos' do
    scenario 'allows the signed in user to add an image and fill out title field, then displays the photo' do
      user_uploads_image
      expect(page).to have_selector('img')
      expect(page).to have_css('img[src*="test.jpg"]')
      expect(page).to have_content 'Sunset'
      expect(current_path).to eq '/photos'
    end

    scenario 'if the user is not signed in they are not able to add a photo' do
      visit '/'
      expect(page).not_to have_content 'Add a photo'
    end
  end

  context 'viewing photos in the show page' do
    before(:each) do
      user_uploads_image
    end

    scenario 'lets a user view photos in the show page' do
      expect(page).to have_selector('img')
      expect(page).to have_css('img[src*="test.jpg"]')
      expect(page).to have_content 'Sunset'
      click_link 'Sunset'
      expect(page).to have_selector('img')
      expect(page).to have_css('img[src*="test.jpg"]')
      expect(page).to have_content 'Sunset'
    end

    scenario 'allows a user to go back to all photos when in the show page' do
      expect(page).to have_selector('img')
      expect(page).to have_css('img[src*="test.jpg"]')
      expect(page).to have_content 'Sunset'
      click_link 'Sunset'
      expect(page).to have_link 'Back'
    end
  end

  context 'editing photos' do
    before(:each) do
      user_uploads_image
    end

    scenario 'allow the creator of the photo edit it only' do
      expect(page).to have_selector('img')
      expect(page).to have_css('img[src*="test.jpg"]')
      expect(page).to have_content 'Sunset'
      expect(current_path).to eq '/photos'
      click_link 'Edit'
      fill_in 'Title', with: 'Dawn'
      click_button 'Update Photo'
      expect(page).to have_selector('img')
      expect(page).to have_css('img[src*="test.jpg"]')
      expect(page).to have_content 'Dawn'
      expect(current_path).to eq '/photos'
    end

    scenario 'a user who does not own the photo can not edit it' do
      expect(page).to have_selector('img')
      expect(page).to have_css('img[src*="test.jpg"]')
      expect(page).to have_content 'Sunset'
      expect(current_path).to eq '/photos'
      click_link 'Sign Out'
      click_link 'Sign Up'
      userbob = build(:userbob)
      sign_up(userbob)
      click_link 'Edit'
      expect(page).to have_selector('img')
      expect(page).to have_css('img[src*="test.jpg"]')
      expect(page).to have_content 'You are unable to edit this photo'
      expect(current_path).to eq '/photos'
    end
  end

  context 'deleting photos' do
    before(:each) do
      user_uploads_image
    end

    scenario 'allows only the creator of the photo to delete the photo' do
      expect(page).to have_selector('img')
      expect(page).to have_css('img[src*="test.jpg"]')
      expect(page).to have_content 'Sunset'
      expect(current_path).to eq '/photos'
      click_link 'Delete'
      expect(page).to_not have_selector('img')
      expect(page).to_not have_css('img[src*="test.jpg"]')
      expect(page).to_not have_content 'Sunset'
      expect(page).to have_content 'Photo deleted successfully'
      expect(current_path).to eq '/photos'
    end

    scenario 'does not allow the non creator of the image to delete the photo' do
      expect(page).to have_selector('img')
      expect(page).to have_css('img[src*="test.jpg"]')
      expect(page).to have_content 'Sunset'
      expect(current_path).to eq '/photos'
      click_link 'Sign Out'
      userbob = build(:userbob)
      sign_up(userbob)
      expect(page).to have_selector('img')
      expect(page).to have_css('img[src*="test.jpg"]')
      expect(page).to_not have_link 'Delete'
      expect(current_path).to eq '/'
    end
  end

private

  def user_uploads_image
    user = build(:user)
    sign_up(user)
    visit '/photos/new'
    fill_in 'Title', with: 'Sunset'
    attach_file('photo[image]', 'spec/features/images/test.jpg')
    click_button 'Create Photo'
  end
end
