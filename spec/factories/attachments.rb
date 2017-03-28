FactoryGirl.define do
  factory :attachment do
    file File.new("#{Rails.root}/spec/support/mocks/attachment1.txt")
    association :attachable
  end
end
