require 'spec_helper'

describe Comment, type: :model do

  context 'relationship with photo' do
    it { is_expected.to belong_to :photo }
  end

  context 'relationshp with the user' do
    it { is_expected.to belong_to :user }
  end
end