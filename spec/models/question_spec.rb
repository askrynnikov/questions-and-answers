require 'rails_helper'

RSpec.describe Question, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  it { is_expected.to validate_presence_of(:title) }
  it { should validate_presence_of(:body) }

  # it 'validates presence of title' do
  #   expect(Question.new(body: '123')).to_not be_valid
  # end
  #
  # it 'validates presence of body' do
  #   expect(Question.new(title: '123')).to_not be_valid
  # end
end
