FactoryGirl.define do
  factory :question do
    title Faker::Lorem.sentence
    body Faker::Lorem.paragraph
    user

    trait :with_answers do
      answers { [create(:answer), create(:answer)] }
    end
  end

  factory :invalid_question, class: "Question" do
    title nil
    body nil
  end
end
