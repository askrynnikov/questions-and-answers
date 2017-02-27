FactoryGirl.define do
  sequence :body do |n|
    "#{Faker::Lorem.paragraph} #{n}"
  end

  factory :answer do
    body
    question
    # association :question, factory: :question, title: "Тестовый вопрос", body: "Чему равно 2 * 2 ?"
    user
  end

  factory :invalid_answer, class: "Answer" do
    body nil
    association :question, factory: :question, title: "Тестовый вопрос", body: "Чему равно 2 * 2 ?"
    user
  end
end
