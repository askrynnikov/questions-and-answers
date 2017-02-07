# frozen_string_literal: true
RSpec.describe Question, type: :model do
  describe 'associations' do
    it do
      should have_many(:answers)
               .dependent(:destroy)
    end
  end

  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:body) }
  end


  # it 'validates presence of title' do
  #   expect(Question.new(body: '123')).to_not be_valid
  # end
  #
  # it 'validates presence of body' do
  #   expect(Question.new(title: '123')).to_not be_valid
  # end
end
