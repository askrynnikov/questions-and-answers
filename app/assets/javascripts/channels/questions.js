var questions_channel;

questions_channel = function() {
  return App.cable.subscriptions.create("QuestionsChannel", {
    received: function(data) {
      // return console.log('received', data);
      return $('.questions').append(JST['templates/question'](data));
    }
  });
};

$(document).ready(questions_channel);

// $(document).on("turbolinks:load", questions_channel);
