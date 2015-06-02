var watchForm = function() {
  $('.signup-link a').on('click', function(e){
    e.preventDefault();

    $('.login-area').hide();
    $('.signup-area').show();
  });

  $('.login-link a').on('click', function(e){
    e.preventDefault();

    $('.signup-area').hide();
    $('.login-area').show();
  });

  $('.new_user').on('submit', function(e){
    e.preventDefault();
    if ($(this).find('input.signup-password').val() === $(this).find('input.signup-password-confirm').val()) {
      $('.new_user').off('submit').submit();
    } else {
      $('.alert').show();
      $('.alert').text('Password Not Matching');
    }

  });
};

var editForm = function() {
  $('.edit_user').on('submit', function(e){
    e.preventDefault();
    var new_pw = $(this).find('[name="user[new_password]"]').val()
    var new_pw2 = $(this).find('[name="user[confirm_password]"]').val()

    if (!(new_pw === new_pw2)) {
      $(this).find('[name="user[new_password]"]').css("border-color", "red")
      $(this).find('[name="user[confirm_password]"]').css("border-color", "red")
    } else {
        $('.edit_user').off('submit').submit();
    };
  });
}

$(document).on('ready', watchForm);
$(document).on('ready', editForm);
