FactoryGirl.define do
  factory :answer do
    body Faker::Lorem.paragraph
    association :question, factory: :question, title: "Тестовый вопрос", body: "Чему равно 2 * 2 ?"
    user
  end

  factory :invalid_answer, class: "Answer" do
    body nil
    association :question, factory: :question, title: "Тестовый вопрос", body: "Чему равно 2 * 2 ?"
    user
  end
end
