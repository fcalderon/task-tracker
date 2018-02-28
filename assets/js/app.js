// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
import "phoenix_html"

// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

// import socket from "./socket"
$(function() {
  const timeBlockListSelector = $('#time-block-list');
  const taskId = timeBlockListSelector.data('task-id');

  $('#direct-timer-button').on('click',function() {
    const timeblock = {
      time_block: {
        start_time: new Date().toISOString()
      }
    };

    $.post('/api/tasks/' + taskId + '/timeblocks', timeblock,
      function(res) {
         const data = res.data;
         timeBlockListSelector.prepend(toListItem(data));
         console.log('Posted open time block', data);
         console.log('Posted open time block', toListItem(data));
    }, 'json');
  });

  timeBlockListSelector.on('click', '.open-time-block', function() {
    const listItemElementSelector = $(this).parent();
    const timeBlockId = $(this).data('time-block-id');

    const timeBlock = {
      time_block: {
        end_time: new Date().toISOString()
      }
    };
    $.ajax({
      type: 'PUT',
      url: '/api/tasks/' + taskId + '/timeblocks/' + timeBlockId,
      data: timeBlock,
      success: function(res) {
        const data = res.data;
        listItemElementSelector.replaceWith(toListItem(data));
        console.log('Closed open time block', data);
      },
      dataType: 'json'
    });

  });
});

function toListItem(timeblock) {
  return '<li class="list-group-item">'
    + timeblock.start_time + ' - '
    + (timeblock.end_time ? timeblock.end_time : '<button class="btn btn-warning open-time-block" data-time-block-id="' + timeblock.id + '">Stop</button>')
    + '</li>';
}