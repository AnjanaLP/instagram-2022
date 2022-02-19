// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
(function () {
  'use strict'

  document.querySelector('#navbarSideCollapse').addEventListener('click', function () {
    document.querySelector('.offcanvas-collapse').classList.toggle('open')
  })
})()

import "@hotwired/turbo-rails"
import "controllers"
import "bootstrap"
