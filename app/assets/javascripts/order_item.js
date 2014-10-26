$(function () {
  $('.postpone').on('click', function (e) {
    preventAllDefaults(e);
    var id = targetSkillId(e);
    var postpone = function (id) {
      return $.ajax({
        type: 'GET',
        url: 'postpone/' + id,
      }).success( function() {
        window.location.reload();
      });
    };
    postpone(id);
  });

  $('.set-due').on('click', function (e) {
    preventAllDefaults(e);
    var id = targetSkillId(e);
    var setDue = function (id) {
      return $.ajax({
        type: 'GET',
        url: 'set-due/' + id,
      }).success( function() {
        window.location.reload();
      });
    };
    setDue(id);
  });

  $('.purchase').on('click', function (e) {
    preventAllDefaults(e);
    var id = targetSkillId(e);
    var setDue = function (id) {
      return $.ajax({
        type: 'GET',
        url: 'purchase/' + id,
      }).success( function() {
        window.location.reload();
      });
    };
    setDue(id);
  });

  var targetSkillId = function (e) {
    var $el = $(e.currentTarget).closest('li');
    return $el.attr('id').split('_')[2];
  };

  var preventAllDefaults = function (e) {
    e.preventDefault();
    e.stopPropagation();
  };
});
