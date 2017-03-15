var comments_channel;

comments_channel = function() {
  var commentable_id, commentable_type, comments_container;
  comments_container = $('.comments');
  commentable_type = comments_container.data('commentable-type');
  commentable_id = comments_container.data('commentable-id');
  return App.cable.subscriptions.create({
    channel: "CommentsChannel",
    commentable_type: commentable_type,
    commentable_id: commentable_id
  }, {
    received: function(data) {
      if (gon.user_id !== data.comment.user_id) {
        comments_container = '.comments-' + commentable_type + '-' + commentable_id;
        return $(comments_container + ' .comments-list').append(JST['templates/comment']({
          content: data.comment.content
        }));
      }
    }
  });
};

$(document).ready(comments_channel);