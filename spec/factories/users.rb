FactoryGirl.define do
  factory :user do
    email 'test@test.com'
    password '12345678'
    password_confirmation '12345678'

  factory :userbob do
    email 'example@example.com'
    password '12345678'
    password_confirmation '12345678'
    end
  end
end