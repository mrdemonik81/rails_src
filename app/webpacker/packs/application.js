/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

// import actioncable;
// import activestorage;
import Rails from 'rails-ujs';
import 'bootstrap'
import 'jquery'
import 'cocoon-js';
import 'select2';
import '../stylesheets/stylesheets.scss'
import 'theme';

console.log('Hello World from Webpacker');
Rails.start();

$(document).ready(function () {
  $('select.select2').select2({
    theme: 'bootstrap4',
  });

  const $userSearchEl = $('.select2-remote.usersearch');
  if($userSearchEl.length > 0) {
    $userSearchEl.select2({
      theme: 'bootstrap4',
      ajax: {
        url: '/admin/candidates',
        dataType: 'json',
        delay: 100,
        data: ({term, page = 1}) => ({
          q: term,
          page: page,
        }),
        processResults: (data) => ({
          results: data.items
        }),
        cache: true,
      },
      // allowClear: true,
      // minimumInputLength: 1,
      // openOnEnter: false,
    })
  }

  // $('#summernote').summernote();
});
