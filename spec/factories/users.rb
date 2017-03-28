FactoryGirl.define do
  sequence :email do |n|
    "user#{n}@test.com"
  end

  factory :user do
    email
    password { Faker::Internet.password(8, 20) }
    password_confirmation { "#{password}" }
    confirmation_token { Faker::Internet.device_token }
    # confirmation_sent_at DateTime.now
    confirmed_at Time.now

    factory :unconfirmed_user do
      confirmation_token nil
      confirmed_at nil
    end
  end
end
