FactoryGirl.define do
  factory :answer do
    body "Равно 4"
    association :question, factory: :question, title: "Тестовый вопрос", body: "Чему равно 2 * 2 ?"
  end

  factory :invalid_answer, class: "Answer" do
    body nil
    association :question, factory: :question, title: "Тестовый вопрос", body: "Чему равно 2 * 2 ?"
  end
end
