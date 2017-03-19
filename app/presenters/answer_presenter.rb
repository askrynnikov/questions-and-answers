class AnswerPresenter

  def as(presence)
    send("present_as_#{presence}")
  end

  def initialize(answer)
    @answer = answer
  end

  private

  def present_as_broadcast
    @answer.as_json(root: true,
                    include: {
                      attachments: {
                        only: :id,
                        methods: %i[file_identifier file_url]
                      },
                      question: {
                        only: :user_id }
                    })
  end
end
