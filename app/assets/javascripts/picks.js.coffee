# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $(".player-select").select2({
    theme: "bootstrap"
  });

  $('.pick_dynamic #team_id').change((e) ->
    team_id = $(this).val();
    unless team_id? and team_id
      return

    $.ajax({
      type: 'GET',
      url: "/teams/" + team_id + "/rounds",
      success: (data) ->
        $('#team_rounds').html(data);
    });
  );
