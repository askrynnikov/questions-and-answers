require 'rails_helper'

RSpec.describe Answer, type: :model do
  it do
    should validate_presence_of(:body)
  end

  it do
    should belong_to(:question)
             .with_foreign_key('question_id')
  end
end
