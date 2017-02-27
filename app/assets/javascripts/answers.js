var edit_answer;

edit_answer = function() {
    return $('.edit-answer-link').click(function(e) {
        var answer_id;
        e.preventDefault();
        $(this).hide();
        answer_id = $(this).data('answerId');
        return $('form#edit-answer-' + answer_id).show();
    });
};

$(document).ready(edit_answer);

$(document).on('page:load', edit_answer);

$(document).on('page:update', edit_answer);

$(document).on("turbolinks:load", edit_answer)

// $(document).on('click', '.edit-answer-link', edit_answer)