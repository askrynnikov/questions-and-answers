FactoryGirl.define do
  sequence :body do |n|
    "Answer text: #{Faker::Lorem.paragraph} #{n}"
  end

  factory :answer do
    body
    question
    user
    factory :invalid_answer, class: "Answer" do
      body nil
      association :question, factory: :question, title: "Тестовый вопрос", body: "Чему равно 2 * 2 ?"
    end
  end
end
