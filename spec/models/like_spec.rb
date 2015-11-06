require 'spec_helper'

describe Like, type: :model do

  context 'the relationship with photo' do
    it { is_expected.to belong_to :photo }
  end

  context 'the relationship with user' do
    it { is_expected.to belong_to :user }
  end
end