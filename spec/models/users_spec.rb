require 'rails_helper'

describe User, type: :model do

  context 'relationship with photos' do
    it { is_expected.to have_many :photos }
  end

  context 'relationship with likes' do
    it { is_expected.to have_many :likes }
  end

  context 'relationship with comments' do
    it { is_expected.to have_many :comments }
  end

  context 'relationship with liked photos' do
    it { is_expected.to have_many :liked_photos }
  end
end