FactoryGirl.define do
  factory :user1 do
    email 'test@test.com'
    password '12345678'
    password_confirmation '12345678'
  end

  factory :user2 do
    email example@example.com
  end
end