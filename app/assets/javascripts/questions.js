var edit_question;

edit_question = function() {
    return $('.edit-question-link').click(function(e) {
        var question_id;
        e.preventDefault();
        $(this).hide();
        question_id = $(this).data('questionId');
        return $('form#edit-question-' + question_id).show();
    });
};

$(document).ready(edit_question);
