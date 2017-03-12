var addVote;

addVote = function () {
  return $('.vote').bind('ajax:success', function (e, data, status, xhr) {
    var response, vote_container, vote_delete_url;
    response = $.parseJSON(xhr.responseText);
    vote_container = '.vote-' + response.votable_type + '-' + response.votable_id;
    $(vote_container + ' .rating').html(response.votable_rating);
    if (response.action === 'create') {
      vote_delete_url = '/votes/' + response.id;
      $(vote_container + ' .vote-up').addClass('hidden');
      $(vote_container + ' .vote-down').addClass('hidden');
      return $(vote_container + ' .vote-cancel').removeClass('hidden').attr('href', vote_delete_url);
    } else {
      $(vote_container + ' .vote-up').removeClass('hidden');
      $(vote_container + ' .vote-down').removeClass('hidden');
      return $(vote_container + ' .vote-cancel').addClass('hidden').attr('href', "#");
    }
  });
};

$(document).ready(addVote);

// $(document).on("turbolinks:load", addVote);
