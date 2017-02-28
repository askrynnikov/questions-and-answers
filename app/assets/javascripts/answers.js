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

// перестает работать для новых и отредактированных
// editAnswer = function() {
//     return $('.edit-answer-link').click(function(e) {
//         var answer_id;
//         e.preventDefault();
//         $(this).hide();
//         answer_id = $(this).data('answerId');
//         return $('form#edit-answer-' + answer_id).show();
//     });
// };

$(document).ready(editAnswer);

// $(document).on("turbolinks:load", editAnswer)


// $(document).on('page:load', editAnswer);
//
// $(document).on('page:update', editAnswer);

// $(document).on('click', '.edit-answer-link', editAnswer)