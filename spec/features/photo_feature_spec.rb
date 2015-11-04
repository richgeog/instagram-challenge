require 'rails_helper'

feature 'photos' do

  context 'no photos have been added' do
    scenario 'should display a propmt to add a photo' do
      user = build(:user)
      sign_up(user)
      visit '/photos'
      expect(page).to have_content 'No photos added!'
      expect(page). to have_link 'Add a photo'
    end
  end

  context 'photos have been added' do
    before do
      # Photo.create(title: 'sunset', attach_file:('restaurant[image]', 'spec/features/images/test.jpg'))
  end

    scenario 'displays all photos that have been uploaded' do
      user = build(:user)
      sign_up(user)
      visit '/photos/new'
      fill_in 'Title', with: 'Sunset'
      attach_file('photo[image]','spec/features/images/test.jpg')
      click_button 'Create Photo'
      expect(page).to have_content('Sunset')
      expect(page).not_to have_content('No photos added')
      click_link 'Sign out'
      user = build(:userbob)
      sign_up(user)
      visit '/photos/new'
      fill_in 'Title', with: 'Sunrise'
      attach_file('photo[image]','spec/features/images/test.jpg')
      click_button 'Create Photo'
      expect(page).to have_content('Sunset')
      expect(page).to have_content('Sunrise')
      expect(page).not_to have_content('No photos added')
    end
  end

  context 'adding photos' do
    scenario 'allows the signed in user to add an image and fill out a field, then displays the photo' do
      user = build(:user)
      sign_up(user)
      click_link 'Add a photo'
      fill_in 'Title', with: 'sunset'
      attach_file('photo[image]', 'spec/features/images/test.jpg')
      click_button 'Create Photo'
      expect(page).to have_content 'sunset'
      expect(current_path).to eq '/photos'
    end

    scenario 'if the user is not signed in they are not able to add a photo' do
      visit '/'
      expect(page).not_to have_content 'Add a photo'
    end
  end

  context 'viewing photos' do
    let!(:sunset){Photo.create(title: 'sunset')}

    scenario 'lets a user view photos' do
      visit '/photos'
      click_link 'sunset'
      expect(page).to have_content 'sunset'
      expect(current_path).to eq "/photos/#{sunset.id}"
    end
  end

  context 'editing photos' do
    before {Photo.create title: 'sunset'}

    scenario 'let users edit a photo' do
      visit '/photos'
      click_link 'Edit sunset'
      fill_in 'Title', with: 'dawn'
      click_button 'Update Photo'
      expect(page).to have_content 'dawn'
      expect(current_path).to eq '/photos'
    end
  end

  context 'deleting photos' do
    before {Photo.create title: 'sunset'}

    scenario 'removes a photo when the user clicks the delete link' do
      visit '/photos'
      click_link 'Delete sunset'
      expect(page).to_not have_content 'sunset'
      expect(page).to have_content 'Photo deleted successfully'
    end
  end
end
