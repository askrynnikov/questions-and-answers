var edit_question;

edit_question = function () {
  return $('.edit-question-link').click(function (e) {
    var question_id;
    e.preventDefault();
    $(this).hide();
    question_id = $(this).data('questionId');
    return $('form#edit-question-' + question_id).show();
  });
};

$(document).ready(edit_question);

// $(function () {
//   return App.cable.subscriptions.create('QuestionsChannel', {
//     connected: function () {
//       console.log('Connected!');
//       // return this.perform('do_something', {text: 'hello'});
//       // return this.perform('echo', {text: 'hello'});
//       return this.perform('follow');
//     },
//     received: function (data) {
//       // return console.log('received', data);
//       return $('.question-list').append(data);
//     }
//   });
// });
