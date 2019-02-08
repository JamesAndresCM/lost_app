// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//= require jquery
//= require jquery-ui
//= require jquery_ujs
//= require popper
//= require bootstrap-sprockets
//= require turbolinks
//= require gritter
//= require moment
//= require moment/es.js
//= require tempusdominus-bootstrap-4.js
//= require rails.validations
//= require rails.validations.simple_form
//= require validations.coffee
//= require select2-full
//= require select2_locale_es
//= require activestorage
//= require jquery.mCustomScrollbar.concat.min
//= require bootstrap-sweetalert
//= require sweet-alert-confirm
//= require rails-timeago-all
//= require_tree .


$(document).on('turbolinks:load', function() {
    //scroll inside site
    var btn = $('#button-scroll');
    $(window).scroll(function() {
      if ($(window).scrollTop() > 300) {
        btn.addClass('show');
      } else {
        btn.removeClass('show');
      }
    });

    btn.on('click', function(e) {
      e.preventDefault();
      $('html, body').animate({scrollTop:0}, '300');
    });


    //scroll index
    var offset = 200;
    var duration = 500;
    $(window).scroll(function() {
      if ($(this).scrollTop() > offset) {
        $('.back-to-top').fadeIn(400);
      } else {
        $('.back-to-top').fadeOut(400);
      }
    });

    $('.back-to-top').click(function(event) {
      event.preventDefault();
      $('html, body').animate({
        scrollTop: 0
      }, 600);
      return false;
    })


     $("#sidebar").mCustomScrollbar({
                theme: "minimal",
                scrollInertia:300
      });
      $('#sidebarCollapse').on('click', function () {
          $('#sidebar, #content').toggleClass('active');
          $('.collapse.in').toggleClass('in');
          $('a[aria-expanded=true]').attr('aria-expanded', 'false');
      });


    /*function validate_radio(validations, $radio) {
            var input_wrap = window.ClientSideValidations.forms.new_post.input_tag.split('<span id="input_tag" />');
            var label_wrap = window.ClientSideValidations.forms.new_post.label_tag.split('<label id="label_tag" />');
 
            if ($radio.find('input[type="radio"]:checked').length) {
                // buttons were checked, so if a previous error message was displayed then get rid of it.
                $radio.find('.field_with_errors > *').unwrap();
                $radio.find('.message').remove();
            } else {
                // no radio buttons in this group were checked so see if we have a presence validator
                var name = ($radio.find('input[type="radio"]').attr('name'));
                console.log(name);
                if (validations.validators[name] && validations.validators[name].presence.length) {
                    var message = '<label class="message">' + validations.validators[name].presence[0].message + '</label>';
 
                    // if we don't already have an error message, then display it
                    if (!$radio.find('field_with_errors').length) {
                        $radio.find('label').first().wrap(label_wrap[0]);
                        $radio.find('> label, > input').wrapAll(input_wrap[0]).parent().append(message);
                    }
                }
            }
        }
 
        $('form').each(function() {
            if (window.ClientSideValidations == undefined) window.ClientSideValidations = {};
            if (window.ClientSideValidations.forms == undefined) window.ClientSideValidations.forms = {};
            var validations = window.ClientSideValidations.forms[$(this).attr('id')];
            console.log(validations);
            if (validations) {
                $(this).submit(function() {
                    // check all radio buttons on submit
                    $(this).find('.radio').each(function() {
                        validate_radio(validations, $(this));
                    });
                });
                $(this).find('.radio input[type="radio"]').blur(function() {
                    validate_radio(validations, $(this).parents('.radio'));
                });
            }
        });*/

});

