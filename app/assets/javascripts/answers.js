// $(function() {
//     return $('form.new_answer').bind('ajax:success', function(e, data, status, xhr) {
//         var answer;
//         answer = $.parseJSON(xhr.responseText);
//         return $('.answers').append('<p>'+answer.body+'</p>');
//     }).bind('ajax:error', function(e, xhr, status, error) {
//         errors = $.parseJSON(xhr.responseText);
//         return $('.answer-errors').append(value);
//     });
// });


var editAnswer;

editAnswer = function() {
    return $('body').on('click', '.edit-answer-link', function(e) {
        var answer_id;
        e.preventDefault();
        $(this).hide();
        answer_id = $(this).data('answerId');
        return $('form#edit-answer-' + answer_id).show();
    });
};

$(document).ready(editAnswer);

// $(function () {
//   return App.cable.subscriptions.create('AnswersChannel', {
//     connected: function () {
//       console.log('Connected!');
//       return this.perform('follow');
//     },
//     received: function (data) {
//       return $('.answers').append(data);
//     }
//   });
// });


// $(document).on("turbolinks:load", editAnswer)


// $(document).on('page:load', editAnswer);
//
// $(document).on('page:update', editAnswer);

// $(document).on('click', '.edit-answer-link', editAnswer)