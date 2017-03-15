var addComment;

addComment = function() {
  return $('.comments').bind('ajax:success', function(e, data, status, xhr) {
    var comments_container, response;
    response = $.parseJSON(xhr.responseText);
    comments_container = '.comments-' + response.commentable_type + '-' + response.commentable_id;
    $(comments_container + ' .comments-list').append(JST['templates/comment'](response));
    return $(comments_container + ' #comment_content').val('');
  });
};

$(document).ready(addComment);

// $(document).on("turbolinks:load", addComment);
