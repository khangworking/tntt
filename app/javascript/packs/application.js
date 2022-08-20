// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

// import Turbolinks from "turbolinks"
// Turbolinks.start()

import Rails from "@rails/ujs"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import "../stylesheets/application.css"
import { Application } from "@hotwired/stimulus"
import { definitionsFromContext } from "@hotwired/stimulus-webpack-helpers"
import { Turbo } from "@hotwired/turbo-rails"
import "cocoon-js-vanilla";
import "flatpickr/dist/flatpickr.min.css"

Turbo.session.drive = false

Rails.start()
ActiveStorage.start()
window.Stimulus = Application.start()
const context = require.context("../controllers", true, /\.js$/)
Stimulus.load(definitionsFromContext(context))
