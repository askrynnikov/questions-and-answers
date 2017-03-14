var answers_channel;

answers_channel = function() {
  var question_id;
  question_id = $('.answers').data('question-id');
  return App.cable.subscriptions.create({
    channel: "AnswersChannel",
    question_id: question_id
  }, {
    received: function(data) {
      if (gon.user_id !== data.answer.user_id) {
        return $('.answers').append(JST['templates/answer'](data));
      }
    }
  });
};

$(document).ready(answers_channel);

// $(document).on("turbolinks:load", questions_channel);
