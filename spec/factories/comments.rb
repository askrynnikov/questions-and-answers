FactoryGirl.define do
  sequence :content do |n|
    "Comment #{n} #{Faker::Lorem.paragraph}"
  end

  factory :comment do
    content
    association :commentable
    user
  end
end
