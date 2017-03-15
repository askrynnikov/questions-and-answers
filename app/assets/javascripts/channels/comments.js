var comments_channel;

comments_channel = function() {
  return App.cable.subscriptions.create({
    channel: "CommentsChannel"
  }, {
    received: function(data) {
      var comments_container;
      if (gon.user_id !== data.comment.user_id) {
        comments_container = '.comments-' + data.commentable_type + '-' + data.comment.commentable_id;
        return $(comments_container + ' .comments-list').append(JST['templates/comment']({
          content: data.comment.content
        }));
      }
    }
  });
};

$(document).ready(comments_channel);